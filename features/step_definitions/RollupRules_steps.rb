Before do
  #@org_builder = OrganizationBuilder.
  class RollupTest; include RollupBuilder; end
  @rollup_builder = RollupTest.new
end

Given /^I have a rollup rules file named "([^"]*)"$/ do |arg1|
  output_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  File.exists?(output_path).should == true
end

Given /^I load the "([^"]*)" rollup file$/ do |arg1|
  input_path = File.dirname(__FILE__) + "/../../examples/" + arg1
  # debugger
  @rollup_builder.load_node input_path
  # debugger
  #   puts 'after rollup'
end

Then /^the total rollup rules collected should be (\d+)$/ do |arg1|
  @rollup_builder.rollup_rule_list.count.should==arg1.to_i
end

Given /^I assign the "([^"]*)" organization \$(\d+)$/ do |arg1, arg2|
	pending # express the regexp above with the code you wish you had
end