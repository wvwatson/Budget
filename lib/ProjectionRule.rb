#require "active_support"

module ProjectionRule

  attr_accessor :name
  attr_accessor :period
  attr_accessor :date
  attr_accessor :ranged
  attr_accessor :range_start_date
  attr_accessor :range_end_date
  attr_accessor :custom_code

  @period = :monthly
  @date = Date.new
  #@end_date = @start_date + 11.months # 1 year default

end