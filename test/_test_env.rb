ROOT_DIR=File.expand_path(File.dirname(__FILE__)+'/..')
require "#{ROOT_DIR}/lib/toast.rb"

Dir.glob("#{ROOT_DIR}/test/helpers/*.rb").each do |file|
  require file
end
