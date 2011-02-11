module RollupBuilder
  
  attr_accessor :rollup_rule_list
  
  def addrule(child)
    @rollup_rule_list.push(child)
  end
  
  # should we use memoization?
  def rollup
    # loop through children from bottom
    
    
    # designate current object and current parent
		# loop through the rollup rules
    @rollup_rule_list.each do |rule|
      
    end

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