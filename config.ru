require 'rubygems'
require 'sinatra'
require 'logger'

set :run, false
set :environment, :development
set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, "views") }
 
require 'app/main'
run Sinatra::Application
