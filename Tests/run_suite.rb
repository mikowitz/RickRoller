require 'spec'

$:.unshift File.dirname(__FILE__) + '/..'

require 'controller'
require 'die'
require 'roller'

Dir.glob(File.expand_path('../**/*_spec.rb', __FILE__)).each { |spec| require spec }
