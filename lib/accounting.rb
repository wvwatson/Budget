# Accounting is tracking the ebb and flow of money through a business entity
# solvency is when cash is greater than bills currently due.
# profitability is when sales is greater than costs and expenses

#accrual based accounting is based on when money is promised
#cash based accounting is when cash actually changes hands

# assets - liabilities = worth
#worth aka net worth aka equity aka owner's equity aka shareholder's equity

require 'revenue'
require 'expenses'
require 'income'

class Journal
end
class FiscalYear
end

class IncomeStatement
end
class CashFlowStatement
end

# assets = liabilities + worth
# A balance sheet should group assets from most liquid to least liquid
# another grouping is: very liquid, productive, and then products for sale
# Liabilities are grouped by to whom the debt is owed
#  then whether it can be paid in 1 year (a current liability)
# Shareholder's equity is a liability that is repaid in the normal course of business
class BalanceSheet
end

#extend number to allow for year mean budget year.  Allow budgets per year and rolling forward per year 
class Year
	#roll forward
end

#use this to list account hierarchry
class ChartOfAccounts
end

#Name of bucket where money is collected
class Account
  attr_accessor :name
  #kind of thing the money is spent on e.g. chairs.  Maybe should be a list
	attr_accessor :Expenditures 
	#rollup account
	attr_accessor :Account 
	attr_accessor :dollars
	attr_accessor :tags
	
	def initialize
    @dollars = 0
    @expenditures=[]
    @tags=[]
  end
  
  def addtags(newtag)
    @tags.push(newtag)
  end
  
  def tags=(newtag)
    @tags.push(newtag)
  end
  
  #should have option to count all sub accounts too
  def add(expenditure)
    @expenditures.push(expenditure)
  end
  
  #accumulate all of the dollars from all of the expenditure and
  #overwrite whatever is in the dollars variable
  def dollars
    @dollars=0
    @expenditures.each do |currentexpenses|
       @dollars += currentexpenses.dollars
    end
    @dollars
  end
  #override the expenditures and set dollars manually
  #accept a hash that creates a new expenditure with cash
  def dollars=(total, exp = {})
    newexp = Expenditure.new
    if exp["name"]
      newexp.BudgetObject.name = exp["name"]
    else
      newexp.BudgetObject.name = "cash"
    end
    newexp.dollars = total
    add(newexp)
  end
end
