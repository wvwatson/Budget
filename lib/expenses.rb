# An expense is money that goes out of the business entity. 
# a cost is not an expense
# an expense is not an expenditure 
#  a cost is money spent making a product or service
#  an expense is money spent to develop, sell, account, and manage the whole making and selling process
#  an expenditure is a cost or expense when it is actually sent to a vendor to pay for it
# need some way to import expenses into expense and budget object collections
#  have a standard budget file format for import.
#  perhaps use activewarehouse etl to import from various systems and formats into the standard budget format
#  should look at a standard format first, then quickbooks, then peoplesoft.

# liabilities and equity
# Accounts Payable K
# Accured Expenses L
# Current Portion of Debt M
# Income Taxes Payable N
# Current Liabilities K + L + M + N is O (not zero)
# Long-Term Debt P
# Capital Stock Q
# Retained Earnings R
# Shareholder's Equity Q + R is S
# Total Liabilities and Equity O + P + S is T
# current liabilities take cash within 1 year of the date on the balance sheet
#  current asset cash pays current liabilities debts
# accounts payable is what is owed to suppliers
# accured expenses is what is owed to employees and others for services rendered
# current debt is what is owed to lenders
# taxes are what is owed to the government
# notes payable and current portion of long term debt fall under current portion of debt
#  Both of these are things payable in the next 12 months
# an example of a long term debt is the mortgage on a building
# income taxes payable is the taxes you pay because you sold something and made a profit, but haven't paid those taxes yet
#  usually paid every three months
# working capital is current liabilities subtracted form current assets
#  amount of money you have to 'work with' in the short term.
#  aka net current assets aka funds
#  flow of working capital
#    current liabilities decrease -> working capital increases
#    current assets increase -> working capital increases
#    current liabilities increase -> working capital decreases
#    current assets decrease -> working capital decreases
#  lots of working capital makes it easier to pay your current liabilities
# Total liabilities is current liabilities and long term debt
#   Long term debt is a loan that takes longer than 12 months to repay
# We will need to have 'defaults' for the tree if a user doesn't supply one 
#  for instance org.name='default', account.name='default' if putting in only expenses

require 'spreadsheet'
  
# something you owe
class Liability
end

# need to have the capability to calculate for a year and for one month
# Build expenses from a expense language
class ExpenseBuilder
  # need some way to reference income
  # maybe use visitor pattern
  # maybe execute block inside the context of an income statement  (which includes expenses and income)
  attr_accessor :budget_builder #ref to parent, be careful here
  #maybe shadow all expense fields to make them available to blocks
  attr_accessor :expense_list
  attr_accessor :period 
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :range_start_date
  attr_accessor :range_end_date
  attr_accessor :one_time_date
  attr_accessor :increment
  #length of the projection. Could be a budget cycle, a calendar year, or a couple months
  attr_accessor :duration
  attr_accessor :cost
  attr_accessor :chance
  
  
  def cost(tempcost)
    #debugger
    expense_list.last.amount=tempcost
    #should raise an error if no expense exists
  end

  # at some point make = work
  # def cost=(tempcost)
  #   cost(tempcost)
  # end
  
  def chance(chance)
    #debugger
    expense_list.last.chance=chance
    #should raise an error if no expense exists
  end
  
  def add_expense(name, amount=0, &block)
	  expense = Expense.new
	  expense.name = name
    expense.amount = amount
    expense.period = @period

    case @period
    when :one_time
      expense.date=@one_time_date
    when :incremental
      expense.date=@increment
    when :ranged
      # fix this to create expenses per period type for the range
      expense.date=@ranged_state_date
    end
    @expense_list.push(expense)
    yield if block_given?
    expense_list.last.custom_code=block
  end
  
  def total
    @expense_list.inject(0) do |result, expense| 
      if expense.chance
        #debugger
        result + expense.amount.to_i * (expense.chance.to_f/100)
      else
        result + expense.amount.to_i
      end  
    end
  end
  
  def every (date, &block)
    #debugger
    if date == :monthly
      period = :monthly
    else
      period=:incremental
      increment=date
    end
    self.instance_eval &block
  end
  
  def from (start_date, end_date, &block)
    #debugger
    period=:ranged
    range_start_date=start_date
    range_end_date=end_date
    self.instance_eval &block
  end
  
  def on (date, &block)
    #debugger
    period=:one_time
    one_time=date
    self.instance_eval &block
  end
  
  # dynamically define expenses
  def method_missing(methId, *args, &block)
    #debugger
    # maybe make more secure/easier to debug by requiring method to have 
    # prefix of exp_ or rev_
    str = methId.id2name
    #debugger
    #debugger if str == 'taxes'
    #need to ensure 1 variable
    if args.count == 0 
      #debugger
      add_expense(str)
      self.instance_eval &block
    elsif args.count == 1 
      add_expense(str, args[0], &block)
    end
    #add define method here
  end

  def mybills(&block) 
    #debugger
    #@expense_list = []
    #myexp = Expense.new
    #Expenses.class_eval &block
    self.instance_eval &block
  end
  
  def initialize
	  #debugger
    @expense_list = []
    @period = :monthly
	  @start_date = Time.now
	  @duration = 1.year # not used yet
	  @end_date = @start_date + 11.months # 1 year default
  end
   
end

class ExpenseProjection
  
  attr_accessor :expense_builder
  attr_accessor :expense_projections
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
    @expense_projections = {}
  end
  
  # create a month expense list based on the what expenses are monthly
  # have a 'current date' and check to see if the "expense rule" has a one time date that falls in the current dates's month
  # create iterators and check against iterators to see if an expense should be added for the current month
  # apply the custom code after the expense has been created
  # may need some concept of current expense list and projection expense list
  #  maybe a hash of months in a hash of years
  def build_projection
    @expense_projections = build_projection_hash(@expense_builder.start_date, @expense_builder.end_date)
    @expense_projections.each do |year, month|
      #loop through each month and create an expense list for that month
      month.each do |expense_month, expense_list|
        # should we make the object an expense or an expense builder .. maybe expense builder
        #  because need ability to apply custom code with context?
        # Need some way to apply the logic for the date we are on
        # loop through each expense rule to check if we should move it over
        @expense_builder.expense_list.each do |expense_rule|
          # if within start and end dates...
          #debugger
          case expense_rule.period
          when :monthly
            # take the closure (custom code) out of this push later
            expense_list.push(expense_rule) 
            
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
    @expense_projections
  end
  # build the months and years
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
    year_hash
  end
  
  
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
     # January              February
     # car_insurance  500   0
     # rent           1000  1000
     # electricity    200   225
     # taxes          100   100
     
     #debugger
     # need to loop through the whole list and get all of the expense names for each month
     #  and include that list for the first column
     last_month_column = -1
     expense_projections.each_with_index do |(year, month_hash), year_index|
       # excelname.row(rownumber)[columnnumber]
	   # year needs to print conditionally if a new year
	   sheet2.row(0)[last_month_column + 1] = year 
	   
       month_hash.each_with_index do |(month, expense_list), month_index|
	   
		  # always shows on the second row (for now)
          sheet2.row(2)[last_month_column + 1] = Date::MONTHNAMES[month]
         
          expense_list.each_with_index do |expense, expense_index|
			  # 2 levels below year
              sheet2.row(expense_index + 2)[last_month_column + 1] =  expense.name
              #sheet2.row(i)[1] =  expense.amount
          end 
          last_month_column += month_index
       end 
     end
     # 
     # #numbers for each month
     # expense_projections.each_with_index do |(year, month_hash), index|
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

class Expense
  attr_accessor :name
  attr_accessor :period
  attr_accessor :date
  attr_accessor :amount
  attr_accessor :chance
  attr_accessor :custom_code
end

class BudgetObject
	attr_accessor :name
	attr_accessor :Description
end

# class Dollars
# end

class Expenditure
  attr_accessor :BudgetObject
  attr_accessor :dollars
  attr_accessor :tags
  
  def initialize
    @BudgetObject = BudgetObject.new
    @tags = []
  end
  
  # def tags=(newtag)
  #    @tags.push(newtag)   
  #  end
  def addtags(newtag)
    @tags.push(newtag)
  end
end