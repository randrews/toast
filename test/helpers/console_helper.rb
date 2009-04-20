def setup_console
  @console=Toast::ConsoleChannel.new Toast::Responder
  
  # make it read/write arrays (instead of Readline)
  class << @console
    attr_accessor :script, :output
    def next_line ; script.shift ; end
    def send msg, to ; output << msg unless msg.nil? ; end
  end
  
  # give it an echo for a responder
  class << @console.responder_for 'console@localhost'
    def respond msg ; msg ; end
  end
  
  @console.script=[]
  @console.output=[]
end
