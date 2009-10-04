require "rubygems"
require "sinatra"
require "gem_helper"

get "/" do
  gem_helper = GemHelper.new
  haml :index, :locals => { :gems => gem_helper.get_gemspecs } 
end

get "/:gem" do
  gem_helper = GemHelper.new
  gems = gem_helper.get_gemspecs
  gem = nil
  gem = gems[params[:gem]] if gems.keys.include? params[:gem]
  haml :gem, :locals => { :gems => gem, :gem_name => params[:gem] }
end

get "/:gem_name/:version" do
  gem_helper = GemHelper.new
  gem = gem_helper.get_gem params[:gem_name], params[:version]
  rdocpath = gem_helper.rdoc_link gem
  haml :gem_version, :locals => {
    :gem => gem, 
    :gem_name => params[:gem_name], 
    :gem_version => params[:version],
    :rdoc => rdocpath}
end
