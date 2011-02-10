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
		# 	designate current object and current parent
		# loop through the rollup rules
		# there are three kinds of matches
    #   1) a 'from' match is when the current object is the 'from' object when
		# 	  there is no 'to' object (wildcard)
		# 	2) a 'to' match is when the current parent is the 'to' object when
		#			there is not 'from object (wildcard)
		#		3) a full match is when the current object and parent match the
		#			'from' and 'to' objects respectively
		# when there is a match call the before rollup logic, then rollup logic,
		# 	then the after rollup logic
		# possibly implement before_all_children/after_all_children
    # when no more children accumulate current object's content

		# possibly create a new control that acts like fold (inject)
		#  and passes in the object currently being rolled up also
		#  processes the objects in an order based on what the objects have listed
		#  in their predefined order attribute.
  end
  
  def initialize
    @rollup_list={}
  end
end