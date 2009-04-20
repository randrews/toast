module Toast
  class Channel
    attr_accessor :responder_class
    attr_accessor :responders
    
    def initialize responder_class
      @responder_class=responder_class
      @responders={}
    end
    
    def handle msg
      responder_for(msg.from).handle msg.text
    end
    
    def next_msg
      Message.new("Override #{self.class.name}.next_msg", 
                  'nobody')
    end

    def responder_for from
      unless @responders[from]
        @responders[from]= @responder_class.new self, from
      end
      @responders[from]
    end

    def send msg, to
      puts "#{to}: #{msg.text}"
    end
  end
end
