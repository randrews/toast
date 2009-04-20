require 'rubygems'

SPEC=Gem::Specification.new do |s|
  s.name='toast'
  s.version='0.0.2'
  s.date='2008-08-24'
  s.author='Andrews, Ross'
  s.email='randrews@geekfu.org'
  s.homepage='http://toastwiki.yellownote.info'
  s.platform=Gem::Platform::RUBY
  s.summary="A framework for making Jabber bots (use with Jelly)"

  s.files=Dir.glob("{.,lib/**}/*.rb")
  s.executables=["toastconsole"]
  s.has_rdoc=false
  s.add_dependency("activesupport",">= 2.1.0")
end
