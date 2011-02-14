# the custom logic requirement was originally made because
# of complexity generally associated with indirect costs
# need to provide a way of taking an object and going down its list and 
#  from the bottom and roll everything up.
# eventually might need a priority (order) for immediate decendants of a tier
# default rollup rule is to go from child to parent, accumulating the 
#  content
require 'DSLTools'
class RollupRule
  
  # These both should be procs that execute in the 
  # context of the includer
  attr_accessor :before_logic 
  attr_accessor :after_logic
  attr_accessor :from
  attr_accessor :to
  attr_accessor :custom_code
  
end



module RollupBuilder
  
  include DSLTools
  
  attr_accessor :rollup_rule_list
  
  # tree example could be this:
  #  (executive (finance (budgeting payroll)) 
  #             (information_technology (helpdesk operations software_development)) 
  #              marketing sales)

  
  def rollup_builder_initialize
    # debugger
    # @rollup_rule_list=[]
    super
  end
  
  
  # should be able to do from or to or both together in a rollup_rule
  
  # assign logic that applies when coming 'from' the content
  def from (*args, &block)
    # recognize the content
    # debugger
    return unless block_given?
    rollup = RollupRule.new
    rollup.from=args[0]
    if args[1].is_a?(Hash) # syntax field_sales reports_to: :sales
      rollup.to = args[1][:to]
    end
		@rollup_rule_list ||=[]
    @rollup_rule_list.push(rollup)
	  @rollup_rule_list.last.custom_code=block
  end
  
  # assign logic that applies when going 'to' the content
  def to (*args, &block)
    # debugger
    return unless block_given?
    rollup = RollupRule.new
    rollup.to=args[0]
    @rollup_rule_list.push(rollup)
	  @rollup_rule_list.last.custom_code=block
  end
  # 
  # def addrule(child)
  #   @rollup_rule_list.push(child)
  # end
    # 
    # 
    # # add a node to the node list and the path list
    # def add_rollup(name, *args, &block)
    #   
    #   # @rollup_rule_list.each do |rollup|
    #   #   if rollup.name == name
    #   #     return # exists already
    #   #   end
    #   # end
    #   #debugger
    #   # node = self.const_get(node_class).new # need to instantiate the including class somehow
    #   # node = @node_class.new
    #   # node.name = name 
    # 
    #   # if args
    #     # @time = args[0][:reports_to] if args[0].is_a?(Hash) 
    #   # end
    #   
    #   if args[0].is_a?(Hash) # syntax field_sales reports_to: :sales
    #       # debugger
    #     node.parent_name = args[0][:reports_to].to_s
    #   elsif node.parent_name == nil # syntax marketing :graphic_design
    #      node.name = name
    #      node.parent_name = args[0].to_s
    #     else
    #     node.parent_name = @parent_stack.last
    #     node
    #   end
    #     # expense.amount = amount
    #     #      expense.period = @period
    # 
    #     # 
    #     #   case @period
    #     #   when :one_time
    #     #     #debugger
    #     #     expense.date=@one_time_date
    #     #   when :incremental
    #     #     expense.date=@increment
    #     #   # when :ranged
    #     #   #      # fix this to create expenses per period type for the range
    #     #   #      expense.date=@ranged_start_date
    #     #   end
    #     #   expense.range_start_date=@range_start_date
    #     #   expense.range_end_date=@range_end_date
    #     #   expense.ranged=@ranged
    #     #        
    #       @node_list.push(node)
    #     #   # run block before adding that code to the expense
    #     # yield if block_given?
    #        @node_list.last.custom_code=block
    #     #   #cleanup here?
    # end
    # 
    # 
    # # dynamically define expenses
    # def method_missing(methId, *args, &block)
    #   #debugger
    #   # maybe make more secure/easier to debug by requiring method to have 
    #   # prefix of exp_ or rev_
    #   str = methId.id2name
    #   debugger
    #   #debugger if str == 'taxes'
    #   #need to ensure 1 variable
    #   if args.count == 0 
    #     #debugger
    #     add_node(str)
    #     @parent_stack.push(str) if block_given?
    #     instance_eval &block if block_given? # needs to call with an arg
    #     @parent_stack.pop if block_given?
    #     # debugger
    #     #puts "after pop"
    #   elsif args.count == 1 
    #     # debugger
    #     add_node(str, *args, &block)
    #   end
    #   #add define method here
    # end  
    # 
  
  # def load_node(filelocation="/../../rollup_list.rb")
  #   # @period = :monthly
  #   # @ranged = nil
  #   contents = File.open(filelocation, 'rb') { |f| f.read }
  #   self.instance_eval contents
  #   debugger
  #    puts "I am here"
  # end

end

module Rollup
  
  # attr_accessor :tree_list #node_list from hierarchy
  
  def rollup_object (current_object, parent_object, rule)
  end
  

  def get_root(root_name)
    root ||=[]
		root.push(@node_list.find{|root| root.name == root_name})
  end
  
  def get_node(name)
		@node_list.find{|root| root.name == name}
		@node_list.find{|root| root.parent_name == nil} if name == :all
  end
  
  def get_descendants (node)
		# debugger
		return unless node
    descendant_tier ||=[]
    @node_list.select{|child| child.parent_name == node.name}
  end
  
  def walk_tree (name)
    return unless name || name == :all
		# debugger
    descendant_tier ||=[]
		descendant_tier = get_descendants(get_node(name)) || []
		descendant_tier.each do |node|
		  # add to the list if nil
		  #  return descendant list or nodes or check nil?
			# debugger
		  tree_list.push(node) unless walk_tree(node.name)
	  end
    
  end

  
  # 1) add the root as current object
  # 2) get the direct descendants of the current object as current tier
  # 3) if no direct descendants pop one tier off the tier stack
	# 3) if there are descendants push them onto the tier stack
	# 4) pop one descendant off of the tier stack
	# 5) (2)
	
  #   descendant_tier = @node_list.select{|child| child.parent_name == node.name}
  #   result << node
  # elsif @node_list.find{|child| child.parent_name == node.name}
  #   result << node
  # elsif result.find{|child| child.parent_name == node.name}
  #   result << node
  # end
  
  # should we use memoization?
  def rollup(root_name=:all)
    debugger
     children = walk_tree(root_name)
		 debugger
			puts 'after walk'
		# 1) add the root as current object
 
		# 2) get the direct descendants of the current object as current tier
    
    # loop through children from bottom
    # designate current object and current parent
    # probably need to use an adjacency list (list of the path) to loop from bottom
    # to top easier
    # select the path
    #   select into path if tree_list current object's name or parent_name is self.name
    #   select into path if tree_list current objects parent_name is in path already
    # @tree_list.select do |node|
    #     case node
    #       when self.name
    #         true
    #       when self.p
    #       
    # end
    # debugger
		root=[]
		root.push(@node_list.find{|root| root.name == root_name})
		descendant_tier =[]
    path= @node_list.inject(root) do |result, node|
      # debugger
			# if name == node.name
				# result << node
			# elsif self.parent_name == node.name
				# result << node
			# elsif result.find{|child| child.parent_name == node.name}
				# result << node
			# end



			# 3) if no direct descendants pop one tier off the tier stack
			# 3) if there are descendants push them onto the tier stack
			# 4) pop one descendant off of the tier stack
			# 5) (2) 
			
			# 1) add the root as current object
			if @node_list.find{|root| root.name == root_name}
			  # 2) get the direct descendants of the current object as current tier
			  descendant_tier = @node_list.select{|child| child.parent_name == node.name}
				result << node
			elsif @node_list.find{|child| child.parent_name == node.name}
				result << node
			elsif result.find{|child| child.parent_name == node.name}
				result << node
			end
    end 
		# col
		# make a function to handle each rule e.g. execute_rollup
		debugger
		# loop through the rollup rules
		@rollup_rule_list.each do |rule|
			# pass the real object?
			rollup_object(node.name, node.parent_name, rule)
		end
		debugger
		puts "after rollup function"
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
end