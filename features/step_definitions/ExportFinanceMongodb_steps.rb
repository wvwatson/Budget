Before do
  Mongoid.configure do |config|
    name = "control_test"
    host = "localhost"
    config.master = Mongo::Connection.new.db(name)
    config.slaves = [
      Mongo::Connection.new(host, 27017, :slave_ok => true).db(name)
    ]
    config.persist_in_safe_mode = false
  end

end
When /^I export the expenses to mongodb$/ do
  #pending # express the regexp above with the code you wish you had
  #debugger
  @expense_projection.expense_builder=@my
  @expense_projection.build_projection
  @expensedb = ExpenseMongo.create(@expense_projection.export_to_hash)
end

Then /^a mongo database should be created$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the mongodb database should have (\d+) columns filled$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
