require 'ProjectionRule'
require 'Projection'
require 'ProjectionRuleBuilder'

class HoursBuilder
  include ProjectionRuleBuilder
  
  attr_accessor :hours_list
  # remove this somehow
  alias rule_list= hours_list= 
  alias rule_list hours_list
  
  def count(hours)
    #debugger
    @hours_list.last.count=hours
    #should raise an error if no expense exists
  end

  def add_hours(name, count=0, *args, &block)
	  hours = Hours.new
    hours.name = name
	  #debugger

	  count = count / 1.hour if count.is_a?(ActiveSupport::Duration)    
	  if args
	    @time = args[0][:at] if args[0].is_a?(Hash) #this for sure needs to be abstracted out!
    end
    hours.count = count
    hours.period = @period

    case @period
    when :one_time
      #debugger
      hours.date=@one_time_date
    when :incremental
      hours.date=@increment
    # when :ranged
    #      # fix this to create hours per period type for the range
    #      expense.date=@ranged_start_date
    end
    hours.range_start_date=@range_start_date
    hours.range_end_date=@range_end_date
    hours.ranged=@ranged
         
    @hours_list.push(hours)
    # run block before adding that code to the hours
    yield if block_given?
    @hours_list.last.custom_code=block
    #cleanup here?
  end
  
  def total
	#debugger
    @hours_list.inject(0) do |result, hours| 
      result + hours.count.to_i
    end
  end
  
  
  # dynamically define expenses
  def method_missing(methId, *args, &block)
    #debugger
    str = methId.id2name
    #debugger
    if args.count == 0 
      #debugger
      add_hours(str)
      instance_eval &block
    elsif args.count == 1 
      #debugger
      add_hours(str, args[0], &block)
    elsif args.count == 2 
        #debugger
        add_hours(str, args[0], args[1], &block)
    end
    #add define method here
  end
  
  def initialize
	  #debugger
    @hours_list = []
    @period = :hourly
	  @start_date = Time.now
	  @duration = 1.year # not used yet
	  @end_date = @start_date + 11.months # 1 year default
	  @date_type = '%m/%d/%Y'
  end
  
  def load_hours(filelocation="/../../hours_list.rb")
    load_file filelocation
  end
  
  
  #Is this really needed anymore?
  class HoursProjection

    include Projection
    alias hours_builder= rule_builder=
    alias hours_builder rule_builder

    alias hours_projections= projection=
    alias hours_projections projection

    def initialize
        @hours_projections = {}
    end

  end
  
  class Hours

    include ProjectionRule
    attr_accessor :count
 
  end
  
end