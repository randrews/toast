require 'rubygems'
require 'active_support'
require 'readline'

Dir.glob("#{File.dirname(__FILE__)}/**/*.rb").each do |file|
  require file
end
