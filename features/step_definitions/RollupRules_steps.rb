Before do
  @org_builder = OrganizationBuilder.new
  class RollupTest; include RollupBuilder; end
  @rollup_builder = RollupTest.new
end


Given /^I have organizations set up$/ do
  steps %Q{
    Given I have an organization file named "organization_list.rb"
    When I load the "organization_list.rb" organization file
  }
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

Given /^I have rollup rules set up$/ do
  steps %Q{
    Given I have a rollup rules file named "rollup_list.rb"
    And I load the "rollup_list.rb" rollup file
  }
end

Given /^I have organizational rollup rules set up$/ do
	input_path = File.dirname(__FILE__) + "/../../examples/" + "rollup_list.rb"
  @org_builder.load_node input_path
end

Given /^I assign the "([^"]*)" organization \$(\d+)$/ do |arg1, arg2|
  #debugger
	@org_builder.node_list.each {|org| org.Account.dollars=arg2.to_i if org.name == arg1}
end

Then /^the rollup result should be \$(\d+)$/ do |arg1|
	debugger
  #@org_builder.rollup_rule_list=@rollup_builder.rollup_rule_list
  @org_builder.rollup.should == arg1.to_i 
end
