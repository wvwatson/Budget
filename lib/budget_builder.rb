# create a builder for all of the kinds of expenses and revenue?
# create a builder that abstracts out personal use and works for just 'income' and 'expenses'?

require "expenses"
require "revenue"

class BudgetBuilder
  attr_accessor :expense_builder
  attr_accessor :revenue_builder
  
  def total_revenue
    @revenue_builder.total
  end
  
  def total_expenses
    @expense_builder.total
  end
end
