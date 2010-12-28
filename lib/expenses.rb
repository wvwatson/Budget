# An expense is money that goes out of the business entity.  
# need some way to import expenses into expense and budget object collections
#  have a standard budget file format for import.
#  perhaps use activewarehouse etl to import from various systems and formats into the standard budget format
#  should look at a standard format first, then quickbooks, then peoplesoft.


class Liability
end

class Expense
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