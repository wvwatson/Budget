#require 'rubygems'
# enable ability to test drive budget language here

require 'sinatra'

get '/' do
  "Hello world, it's #{Time.now} at the server!  
   Upload an excel file to get started"
end