require "rubygems"
require "sinatra"
require "helper"

get "/" do
  haml :index 
end
