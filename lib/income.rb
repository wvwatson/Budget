require 'spreadsheet'
require 'ProjectionRule'
require 'Projection'
require 'ProjectionRuleBuilder'

class IncomeBuilder
  
  include ProjectionRuleBuilder
  
  attr_accessor :income_list
  # remove this somehow
  alias rule_list= income_list= 
  alias rule_list income_list
  attr_accessor :budget_builder #ref to parent, be careful here
  attr_accessor :duration
  attr_accessor :cost
  attr_accessor :chance
  attr_accessor :date_type

  def credit(addcredit)
    #debugger
    @income_list.last.amount=addcredit
    #should raise an error if no credit exists
  end

  def chance(chance)
    #debugger
    @income_list.last.chance=chance
    #should raise an error if no credit exists
  end

  def add_credit(name, amount=0, &block)
	  income = Income.new
	  income.name = name
    income.amount = amount
    income.period = @period

    case @period
    when :one_time
      #debugger
      income.date=@one_time_date
    when :incremental
      income.date=@increment
    end
    income.range_start_date=@range_start_date
    income.range_end_date=@range_end_date
    income.ranged=@ranged

    @income_list.push(income)

    yield if block_given?
    @income_list.last.custom_code=block
    #cleanup here?
  end

  def total
    @income_list.inject(0) do |result, income| 
      if income.chance
        #debugger
        result + income.amount.to_i * (income.chance.to_f/100)
      else
        result + income.amount.to_i
      end  
    end
  end

  # dynamically define income
  def method_missing(methId, *args, &block)
    #debugger
    str = methId.id2name
    #debugger
    if args.count == 0 
      #debugger
      add_credit(str)
      instance_eval &block
    elsif args.count == 1 
      #debugger
      add_credit(str, args[0], &block)
    end
    #add define method here
  end

  def initialize
	  #debugger
    @income_list = []
    @period = :monthly
	  @start_date = Time.now
	  @duration = 1.year # not used yet
	  @end_date = @start_date + 11.months # 1 year default
	  @date_type = '%m/%d/%Y'
  end

  def load_income(filelocation="/../../income_list.rb")
    load_file filelocation
  end   

end

#Is this really needed anymore?
class IncomeProjection

  include Projection
  alias income_builder= rule_builder=
  alias income_builder rule_builder

  alias income_projections= projection=
  alias incom_projections projection

  def initialize
      @income_projections = {}
  end

end

class Income

  include ProjectionRule
  attr_accessor :amount
  attr_accessor :chance

end
