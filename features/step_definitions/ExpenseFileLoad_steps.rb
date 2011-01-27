Given /^I have an expense file named "([^"]*)"$/ do |arg1|
  output_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  File.exists?(output_path).should == true
end

Given /^I load the "([^"]*)" expense file$/ do |arg1|
  #pending # express the regexp above with the code you wish you had
  input_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  #debugger
  @my.load_expenses input_path
    
  #@my.add {require input_path}

  #@my.add input_path
  # @my.add { on '8/3/2011' do
  #     birthday 250
  #   end
  #   }
  
  # @my.instance_eval " on '8/3/2011' do
  #   birthday 250
  # end "
  # contents = File.open(input_path, 'rb') { |f| f.read }
  # @my.instance_eval contents
end
