require 'rubygems'
require 'ftools'

class GemHelper

  def get_gem(gem_name, version)
    all_gems = get_gemspecs
    
    if all_gems.keys.include? gem_name
      all_gems[gem_name].each do |gem|
        return gem if gem.version.to_s == version
      end
    end
    return nil
  end

  def get_all_gemspecs_files
    all_gemspecs = []
    Gem.path.each do |path|
      dir = File.join(path,'specifications') 
      Dir.new(dir).each do |file|
        all_gemspecs << File.join(dir, file) if file != "." and file != '..' 
      end
    end
    return all_gemspecs
  end

  def get_gemspecs 
    files = get_all_gemspecs_files
    gemspecs = {}
    files.each do |spec|
      gem = Gem::Specification.load spec
      if gemspecs.keys.include? gem.name
        gemspecs[gem.name] << gem
      else
        gemspecs[gem.name] = [gem]
      end
    end
    return gemspecs
  end

  def rdoc_link (gem)
    specs = get_all_gemspecs_files
    specs.each do |spec|
      if spec.include? gem.name
        path = File.join(File.dirname(spec),'..','doc')
        gem_name = filename(spec).gsub('.gemspec','')
        return link = File.join(path, gem_name,'rdoc' )
      end
    end
  end

  def filename(path)
    path.split('/').slice(-1)
  end

end
