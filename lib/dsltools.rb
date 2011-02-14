module DSLTools
  def load_node(filelocation="/../../node_list.rb")
    # @period = :monthly
    # @ranged = nil
    debugger
    contents = File.open(filelocation, 'rb') { |f| f.read }
    self.instance_eval contents
    debugger
    puts "I am here"
  end
end