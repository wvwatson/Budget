class Calculator
  def initialize
    @stack = []
  end

  def enter( value ) 
    @stack.push value
  end

  def screen
    @stack[0]
  end

  def add
    @stack.push( @stack.pop + @stack.pop )
  end
end
