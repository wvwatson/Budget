#require 'rubygems'
# enable ability to test drive budget language here
# have a rules window and then use ajax to do real-time updates an income/balance/cashflow statement
#  have capability to drill down into specific months or scroll to specific accounts/groups
require 'sinatra'

get '/' do
  "Hello world, it's #{Time.now} at the server!  
   Upload an excel file to get started"
end