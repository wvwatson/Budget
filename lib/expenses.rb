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


# something you owe
class Liability
end

# need to have the capability to calculate for a year and for one month
# Build expenses from a expense language
class ExpenseBuilder
  #maybe shadow all expense fields to make them available to blocks
  attr_accessor :expense_list
  attr_accessor :period 
  attr_accessor :start_date
  attr_accessor :range_start_date
  attr_accessor :range_end_date
  attr_accessor :one_time_date
  attr_accessor :increment
  #length of the projection. Could be a budget cycle, a calendar year, or a couple months
  attr_accessor :duration
  attr_accessor :cost
  attr_accessor :chance
  
  def cost(cost)
    #debugger
    expense_list.last.amount=cost
    #should raise an error if no expense exists
  end
  
  def chance(chance)
    #debugger
    expense_list.last.chance=chance
    #should raise an error if no expense exists
  end
  
  def add_expense(name, amount=0)
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
    str = methId.id2name
    #debugger
    #need to ensure 1 variable
    if args.count == 0 
      #debugger
      add_expense(str)
      self.instance_eval &block
    elsif args.count == 1 
      add_expense(str, args[0])
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
	  @duration = 1.year 
  end
end

class Expense
  attr_accessor :name
  attr_accessor :period
  attr_accessor :date
  attr_accessor :amount
  attr_accessor :chance
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