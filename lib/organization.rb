class OrganizationBuilder

  attr_accessor :organization_list
  
  def initialize
	@organization_list = []
  end
  
  def add_org(name, &block)
    organization = Organization.new
    organization.name = name
 
      # expense.amount = amount
      #      expense.period = @period

	  # 
	  #   case @period
	  #   when :one_time
	  #     #debugger
	  #     expense.date=@one_time_date
	  #   when :incremental
	  #     expense.date=@increment
	  #   # when :ranged
	  #   #      # fix this to create expenses per period type for the range
	  #   #      expense.date=@ranged_start_date
	  #   end
	  #   expense.range_start_date=@range_start_date
	  #   expense.range_end_date=@range_end_date
	  #   expense.ranged=@ranged
	  #        
	    @organization_list.push(organization)
	  #   # run block before adding that code to the expense
      # yield if block_given?
	  #   @expense_list.last.custom_code=block
	  #   #cleanup here?
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
      add_org(str)
      instance_eval &block if block_given? # needs to call with an arg
     # elsif args.count == 1 
     #   #debugger
     #   add_expense(str, args[0], &block)
    end
    #add define method here
  end  
  
  
  def load_organization(filelocation="/../../organization_list.rb")
    # @period = :monthly
    # @ranged = nil
    contents = File.open(filelocation, 'rb') { |f| f.read }
    self.instance_eval contents
	# debugger
	puts "I am here"
  end 
  
end

class Organization
  attr_accessor :name
  attr_accessor :parent_name
end