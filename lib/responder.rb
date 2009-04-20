module Toast
  class Responder
    attr_accessor :from
    
    def initialize channel, from
      @channel=channel
      @from=from
    end
    
    def handle msg
      callcc do |back_to_channel|
        @back_to_channel = back_to_channel
        
        if @leftoff
          @leftoff.call(msg)
        else
          response=respond(msg)
          say response unless response.nil?
          @leftoff=nil
          @back_to_channel.call
        end
      end
    end
    
    ### Override me to handle messages!
    def respond msg
      say "Override #{self.class.name}.respond to have your bot do something."
      nil
    end
    
    def wait
      callcc do |cc|
        @leftoff=cc
        @back_to_channel.call
      end
    end
    
    def say msg
      @channel.send msg, @from
      nil
    end
  end
end
