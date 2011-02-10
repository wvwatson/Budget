# need to provide a way of taking an object and going down its list and 
#  from the bottom up roll everything up.
# eventually might need a priority (order) for decendants of a tier
# default rollup rule is to go from child to parent, accumulating the 
#  content
module rollup
  
  # These both should be procs that execute in the 
  # context of the includer
  attr_accessor :before_logic 
  attr_accessor :after_logic
  attr_accessor :rollup_list
  
  
  # should be able to do from or to or both together in a rollup_rule
  
  # assign logic that applies when coming 'from' the content
  def from (content)
    # recognize the content
    
  end
  
  # assign logic that applies when going 'to' the content
  def to (content)
  end
  
  def rollup
    # loop through children from bottom
    # call rollup function on each child
    # If no child accumulate?
    # check if there is from recognizer with no to recognizer and vice versa
    # check if there is both
    
    # call specialized logic
    #
  
  end
  
  def initialize
    @rollup_list={}
  end
end