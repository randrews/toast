SPEC=Gem::Specification.new do |s|
  s.name='toast'
  s.version='0.0.3'
  s.date='2009-07-27'
  s.author='Andrews, Ross'
  s.email='randrews@geekfu.org'
  s.homepage='http://toastwiki.yellownote.info'
  s.platform=Gem::Platform::RUBY
  s.summary="A framework for making Jabber bots"

  s.files=["lib/channel.rb",
           "lib/console_channel.rb",
           "lib/console_utils.rb",
           "lib/cont.rb",
           "lib/responder.rb",
           "lib/test_channel.rb",
           "lib/toast.rb",
           "lib/util.rb",
           "example/hangman_responder.rb",
           "example/simple_responder.rb",
           "example/wait_responder.rb"]

  s.executables=["toastconsole"]
  s.has_rdoc=false
  s.add_dependency("activesupport",">= 2.1.0")
end
