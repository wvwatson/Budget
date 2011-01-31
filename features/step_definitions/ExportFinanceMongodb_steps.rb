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
  @expensedb = ExpenseMongo.create(@expense_projection.export_to_mongodb)
end

Then /^a mongo database should be created$/ do
  #debugger
  ExpenseMongo.first().should_not be_nil
  #ExpenseMongo.first(:conditions => {:Amount=>"750"}).should_not be_nil
  #pending # express the regexp above with the code you wish you had
  
end

Then /^the mongodb database should have (\d+) columns filled$/ do |arg1|
  #myall = ExpenseMongo.all()
  #myall.distinct(:month).count
  #myall.entries
  
  ExpenseMongo.all.distinct(:month).count.should == arg1.to_i
  #pending # express the regexp above with the code you wish you had
end

After do
  ExpenseMongo.destroy_all()
end
