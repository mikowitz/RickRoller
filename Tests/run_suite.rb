require 'spec'

$:.unshift File.dirname(__FILE__) + '/..'

require 'die'
require 'roller'
require 'simple_roll_controller'

Dir.glob(File.expand_path('../**/*_spec.rb', __FILE__)).each { |spec| require spec }
