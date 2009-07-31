Gem::Specification.new do |s|
  s.name='toast'
  s.version='0.0.4'

  s.date='2009-07-27'
  s.authors=['Ross Andrews']
  s.email='randrews@geekfu.org'
  s.homepage='http://toastwiki.yellownote.info'
  s.summary="A framework for making Jabber bots"
  s.description="A framework for making Jabber bots"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
  end

  s.platform=Gem::Platform::RUBY

  s.files=["lib/channel.rb",
           "lib/console_channel.rb",
           "lib/console_utils.rb",
           "lib/cont.rb",
           "lib/responder.rb",
           "lib/test_channel.rb",
           "lib/toast.rb",
           "lib/util.rb",
	   "bin/toastconsole",
           "example/hangman_responder.rb",
           "example/simple_responder.rb",
           "example/wait_responder.rb"]

  s.executables=["toastconsole"]
  s.has_rdoc=false
  s.add_dependency("activesupport",">= 2.1.0")
end
