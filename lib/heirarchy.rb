# tree example could be this:
#  (executive (finance (budgeting payroll)) 
#             (information_technology (helpdesk operations software_development)) 
#              marketing sales)

# one way to implement this:
# implement an cons cell
# this is an object that holds a pointer to the next item (parent) in the list 
# implement an object that holds a list of cons cells

# a tree always has a nodes or edges
# acts like cons cell
module Hierarchy
  attr_accessor :name # no doubt some would want this to be id insteadt
  attr_accessor :parent_name # no doubt some would like this to be parent_id instead
  attr_accessor :node_class
  
  # need to try to instantiate the right class somehow
  def self.included(base)
    # base.extend(ClassMethods)
    node_class=base.class
  end
end

# # Describes the path to the parent as a list of unique
# # identifiers
# module HierarchyList
#   attr_accessor :path_list
#   def initialize
#     @path_list = []
#   end
# end

# acts like a list of cons cells
module HierarchyBuilder
  
  attr_accessor :node_list # list of 
  attr_accessor :parent_stack
  attr_accessor :node_class
  
  def initialize
	  @node_list = []
	  @parent_stack = []
  end
  
  # add a node to the node list and the path list
  def add_node(name, *args, &block)
    
    @node_list.each do |node|
      if node.name == name
        return # exists already
      end
    end
      
    node = self.const_get(node_class).new # need to instantiate the including class somehow
    node.name = name 

    # if args
      # @time = args[0][:reports_to] if args[0].is_a?(Hash) 
    # end
    
    if args[0].is_a?(Hash) # syntax field_sales reports_to: :sales
			# debugger
      node.parent_name = args[0][:reports_to].to_s
    elsif node.parent_name == nil # syntax marketing :graphic_design
       node.name = name
       node.parent_name = args[0].to_s
		else
      node.parent_name = @parent_stack.last
      node
    end
      # expense.amount = amount
      #      expense.period = @period

	  # 
	  #   case @period
	  #   when :one_time
	  #     #debugger
	  #     expense.date=@one_time_date
	  #   when :incremental
	  #     expense.date=@increment
	  #   # when :ranged
	  #   #      # fix this to create expenses per period type for the range
	  #   #      expense.date=@ranged_start_date
	  #   end
	  #   expense.range_start_date=@range_start_date
	  #   expense.range_end_date=@range_end_date
	  #   expense.ranged=@ranged
	  #        
	    @node_list.push(node)
	  #   # run block before adding that code to the expense
      # yield if block_given?
	  #   @expense_list.last.custom_code=block
	  #   #cleanup here?
  end


  # dynamically define expenses
  def method_missing(methId, *args, &block)
    #debugger
    # maybe make more secure/easier to debug by requiring method to have 
    # prefix of exp_ or rev_
    str = methId.id2name
    # debugger
    #debugger if str == 'taxes'
    #need to ensure 1 variable
    if args.count == 0 
      #debugger
      add_node(str)
      @parent_stack.push(str) if block_given?
      instance_eval &block if block_given? # needs to call with an arg
      @parent_stack.pop if block_given?
      # debugger
      #puts "after pop"
    elsif args.count == 1 
      # debugger
      add_node(str, *args, &block)
    end
    #add define method here
  end  
  
  
  def load_node(filelocation="/../../node_list.rb")
    # @period = :monthly
    # @ranged = nil
    contents = File.open(filelocation, 'rb') { |f| f.read }
    self.instance_eval contents
    #debugger
	  #puts "I am here"
  end
  
  
end