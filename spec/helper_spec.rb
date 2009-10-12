require 'rubygems'
require 'spec'
require 'mocha'
require File.expand_path(File.dirname(__FILE__) + '/../gem_helper')

describe GemHelper,"Metodos que trazem valores da gem" do

  before(:all) do
    @gem_dir_base = ['/teste/', '/teste/2/']
    @gemhelper = GemHelper.new
    @spec_dir = 'specifications'
    Gem.expects(:path).returns(@gem_dir_base)
  end

  it 'retorna uma lista com o caminho fisico dos specs das gems' do
    first_dir = File.join(@gem_dir_base[0], @spec_dir)
    second_dir = File.join(@gem_dir_base[1], @spec_dir)
    filename = 'gem-de-teste.spec'

    Dir.expects(:new).with(first_dir).returns(filename)
    Dir.expects(:new).with(second_dir).returns([])
    specs = @gemhelper.get_all_gemspecs_files
    specs.should == [File.join(first_dir, filename)]
  end

  it 'retorna o nome do arquivo' do
    name = @gemhelper.filename('/a/b/c')
    name.should == 'c'
  end

  it 'retorna o path para pasta rdoc da gem' do
    spec_file = 'file-1.1.0.gemspec'
    path = File.join(@gem_dir_base[1], @spec_dir, spec_file)
    @gemhelper.expects(:get_all_gemspecs_files).returns(path)
    gem_spec = Gem::Specification.new
    gem_spec.expects(:name).returns('file')

    rdoc_dir = @gemhelper.rdoc_link gem_spec
    expect = File.join(@gem_dir_base[1], @spec_dir, '../doc/file-1.1.0/rdoc')
    rdoc_dir.should == expect
  end
  
  it 'retorna a instancia dos gemspecs instalados' do
    
  end
end
