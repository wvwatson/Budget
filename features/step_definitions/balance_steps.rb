Before do
  @expenditure = Expenditure.new
  @account = Account.new
  @organization = Organization.new
  @sourceoffunds1 = SourceOfFunds.new
  @sourceoffunds2 = SourceOfFunds.new
end

Given /^I have an assigned source of funds with \$(\d+)$/ do |arg1|
    @sourceoffunds1.dollars = arg1
end

Given /^the total of an organization's expenditures is \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I check the balance$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the balance should be \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the balance should be \-\$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^I have an unassigned source of funds with \$(\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
