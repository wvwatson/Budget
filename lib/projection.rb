
# pull out what it is to be a projection so that we can mix it in with 
# things that can be projected like an income statment, an expense, income, (hours?) etc
module Projection
  
  attr_accessor :rule_builder
  attr_accessor :projection
  # create a loop based on month starting at the start date and ending at duration
  # create a month expense list based on the what expenses are monthly
  # have a 'current date' and check to see if the expense has a one time date that falls in the current dates's month
  # create iterators and check against iterators to see if an expense should be added for the current month
  # apply the custom code after the expense has been created
  # may need some concept of current expense list and projection expense list
  #  maybe a hash of months in a hash of years
  # def build_projection
  # 
  # 
  # 
  #  
  # end
 
  def initialize
    @projection = {}
  end
  
  # Builds a hash of years and months
  # possibly extend to handle days and hours
  def build_projection_hash(date,laterdate)
    
    # instantiate a hash of hashes
    year_hash = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) }
    
    (date.year..laterdate.year).each do |y|
      
      # if the current year is not part of the start date, we must be on the
      # the first month of the next year
      mo_start = (date.year == y) ? date.month : 1
      # if the current year is not part of the end date, we must be on 
      # the last month of the year
      mo_end = (laterdate.year == y) ? laterdate.month : 12

      (mo_start..mo_end).each do |m|  
          #puts Date::MONTHNAMES[m]
          year_hash[y][m]=[]
      end
    end
    year_hash # can we get rid of this?
  end
  
  # Populates a hash of years and months with rules (e.g. expenses) are monthly
  # have a 'current date' and check to see if the "expense rule" has a one time date that falls in the current dates's month
  # create iterators and check against iterators to see if an expense should be added for the current month
  # apply the custom code after the expense has been created
  # may need some concept of current expense list and projection expense list
  #  maybe a hash of months in a hash of years
  def build_projection
    @projection = build_projection_hash(@rule_builder.start_date, @rule_builder.end_date)
    @projection.each do |projecion_year, projection_month_hash|
      #loop through each month and create an expense list for that month
      projection_month_hash.each do |projection_month, projection_rule_list|
        # should we make the object an expense or an expense builder .. maybe expense builder
        #  because need ability to apply custom code with context?
        # Need some way to apply the logic for the date we are on
        # loop through each expense rule to check if we should move it over
        #debugger # if expense_month == 8
        @rule_builder.rule_list.each do |rule|
          # if within start and end dates...
          #debugger
          case rule.period # make this mixed in
          when :monthly
            # take the closure (custom code) out of this push later
            if (rule.ranged==true) 
              #debugger
              if (projection_month >= rule.range_start_date.month) && 
                (projection_month <= rule.range_end_date.month)
                projection_rule_list.push(rule.dup)
              else # if not in range, we want a named expense of 0 to be added
                projection_rule_list.push(rule.dup)
                projection_rule_list.last.amount=0
              end
            else
              projection_rule_list.push(rule.dup)
            end 
          when :incremental
            if (rule.ranged==true) 
               #debugger
               if (projection_month >= rule.range_start_date.month) && 
                 (projection_month <= rule.range_end_date.month)
                 projection_rule_list.push(rule.dup) 
               else # if not in range, we want a named expense of 0 to be added
                 projection_rule_list.push(rule.dup)
                 projection_rule_list.last.amount=0 # need to find a way to have this be a call back
               end
             end
            #elsif expense_rule.duration
          when :one_time 
            #debugger if expense_month == 8
            if rule.date.month==projection_month
            #if month(expense_rule.date)==month_number
              # expense_result + expense.amount.to_i
              projection_rule_list.push(rule.dup)
            else # if the specific month, we want a named expense of 0 to be added
              #debugger if expense_month == 8
              projection_rule_list.push(rule.dup)
              projection_rule_list.last.amount=0
            end
          when :ranged 
            #debugger
            if (projection_month >= rule.range_start_date.month) and (projection_month <= rule.range_end_date.month)
            #if month(expense_rule.date)==month_number
              # expense_result + expense.amount.to_i
              #debugger
              projection_rule_list.push(rule.dup)
            else # if not in range, we want a named expense of 0 to be added
              projection_rule_list.push(rule.dup)
              projection_rule_list.last.amount=0
            end
          end
          
          # need to apply custom code.  will it be executed in the context of expense or expense builder?
          # perhaps three levels of context for the custom code:
          #  1) context of 1 expense (allows for calcuation based on the rule itself e.g. the rule cost)
          #  2) context of all expenses and expense rules for a month (mutiple rules get applied fifo)
          #  3) context of 
        end
      end
    end
    #debugger
    @projection
  end
  
  
  def projection_total(projection_type=:all)
    @projection.inject(0) do |year_result, (year_name, month_hash)|
      #puts year_name
      year_result + month_hash.inject(0) do |month_result, (month_number, rule_list)|
        #puts month_name 
        #puts month_result.to_s
        #debugger
        month_result + rule_list.inject(0) do |rule_result, rule|
          #puts expense.name + ' ' +expense.period.to_s + ' ' + expense.amount.to_s 
          #puts ' count: ' + expense_list.count.to_s
          #debugger if expense_type = :one_time
          if (rule.period == projection_type) or (projection_type == :all)
            #puts "made it in: " + expense.name + ' ' +expense.period.to_s + ' ' + expense.amount.to_s 
            # debugger #if expense_type == :one_time
            # case expense.period
            # when :monthly
            #   expense_result + expense.amount.to_i
            # when :one_time 
            #   if month(expense.date)==month_number
                #debugger if expense.amount.nil?
                rule_result + rule.amount.to_i  # need a way to do a call back for this
             # end
            # end
          elsif (projection_type==:ranged) and (rule.ranged==true)
            rule_result + rule.amount.to_i  # need a call back here
          else
            rule_result + 0
          end
        end
      end
      #year_result + month_acc
    end
  end
  
  # # if you use this you'll probably need to use an instance variable?
  #  def every_expense (&block)
  #    @projection.each do |year, month|
  #       #loop through each month and create an expense list for that month
  #       month.each do |expense_month, expense_list|
  #         # should we make the object an expense or an expense builder .. maybe expense builder
  #         #  because need ability to apply custom code with context?
  #         # Need some way to apply the logic for the date we are on
  #         # loop through each expense rule to check if we should move it over
  #         @rule_builder.expense_list.each do |expense_rule|
  #           # if within start and end dates...
  #           #debugger
  #           case expense_rule.period
  #           when :monthly
  #             # take the closure (custom code) out of this push later
  #             expense_list.push(expense_rule) 
  # 
  #           end
  # 
  #           # need to apply custom code.  will it be executed in the context of expense or expense builder?
  #           # perhaps three levels of context for the custom code:
  #           #  1) context of 1 expense (allows for calcuation based on the rule itself e.g. the rule cost)
  #           #  2) context of all expenses and expense rules for a month (mutiple rules get applied fifo)
  #           #  3) context of 
  #         end
  #       end
  #     end
  #  end
  #  
  def export_excel
     #debugger
     #filepath = File.dirname(__FILE__)+"/test_input.xls" 
     #File.open(filepath, "w"){|f| Net::HTTP.start("kangarooit.com") { |http| resp = http.get("/test/test_input.xls"); f.write(resp.body)} }

     #spreadsheet = Spreadsheet.open(filepath)
     #sheet = spreadsheet.worksheets.first
     output_path = File.dirname(__FILE__) + "/expenses.xls"

     book = Spreadsheet::Workbook.new
     sheet2 = book.create_worksheet
     # sheet2.row(0)[0] = 1
     # sheet2.row(0)[1] = 2
     # sheet2.row(1)[0] = 3
     # sheet2.row(1)[1] = 4
     
     # start on the second row
  
  
	 # maybe create a header and groups that are
     # we want something like this:
     
     # 2011
     #                January     February
     # car_insurance  500         0
     # rent           1000        1000
     # electricity    200         225
     # taxes          100         100
     
     #debugger
     # need to loop through the whole list and get all of the expense names for each month
     #  and include that list for the first column
     last_month_column = -1
     projection.each_with_index do |(year, month_hash), year_index|
       # excelname.row(rownumber)[columnnumber]
	   # year needs to print conditionally if a new year
	   #sheet2.row(0)[last_month_column + 1] = year 
	     #debugger
       month_hash.each_with_index do |(month, expense_list), month_index|
	        #debugger
		      # always shows on the second row (for now)
          #sheet2.row(2)[last_month_column + 1] = Date::MONTHNAMES[month]
          #debugger
          expense_list.each_with_index do |expense, expense_index|
			  # 2 levels below year
			        #debugger
              sheet2.row(expense_index + 2)[last_month_column + 1] =  expense.name
              #sheet2.row(i)[1] =  expense.amount
          end 
          #debugger
          last_month_column += 1
          #exit after one listing of expense names
          break
       end 
       #debugger
     end
     
     
     #debugger
      # need to loop through the whole list and get all of the expense names for each month
      #  and include that list for the first column
      #last_month_column = 0
      projection.each_with_index do |(year, month_hash), year_index|
        # excelname.row(rownumber)[columnnumber]
 	   # year needs to print conditionally if a new year
 	   sheet2.row(0)[last_month_column + 1] = year 
 	     #debugger
        month_hash.each_with_index do |(month, expense_list), month_index|
 	        #debugger
 		      # always shows on the second row (for now)
           sheet2.row(1)[last_month_column + 1] = Date::MONTHNAMES[month].dup
           expense_list.each_with_index do |expense, expense_index|
 			  # 2 levels below year
 			      # check month against ranged start and end dates
 			      # if incremental check duration and expense *rule* start date
 			        #debugger
               sheet2.row(expense_index + 2)[last_month_column + 1] =  expense.amount
           end 
           #debugger
           last_month_column += 1
        end 
        #debugger
      end
      
     # 
     # #numbers for each month
     # projection.each_with_index do |(year, month_hash), index|
     #   sheet2.row(i)[0] = year
     #   expense_list.each_with_index do |expense, i|
     #      sheet2.row(i)[0] =  expense.name
     #      sheet2.row(i)[1] =  expense.amount
     #   end 
     # end
     #puts sheet2.row(1)[0].data.inspect
     #puts sheet2.row(1)[1].data.inspect
     # note that the formula in sheet2.row(1)[1].data is significantly larger than the one in sheet2.row(1)[0].data
     book.write output_path

     # Not sure how to programatically test the fact that cell A2 doesn't render in excel ( on linux openoffice) - it should show 365

     # The following expectation passes which means that under the covers, the formula is essentially correct:
     # Spreadsheet.open(output_path).worksheets.first.row(1)[0].value.should eql(365.0)
     #puts Spreadsheet.open(output_path).worksheets.first.row(1)[0].data.inspect

   end
end