Before do
  @org_builder = OrganizationBuilder.new
end

Given /^I have an organization file named "([^"]*)"$/ do |arg1|
  output_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  File.exists?(output_path).should == true
end

Given /^I load the "([^"]*)" organization file$/ do |arg1|
  input_path = File.dirname(__FILE__) + "/../../examples/" + arg1
   debugger
  @org_builder.load_organization input_path
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

Then /^the total organizations collected should be (\d+)$/ do |arg1|
  @org_builder.organization_list.count.should==arg1.to_i
end
