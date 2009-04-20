module Toast
  class TestChannel < Channel
    attr_accessor :output

    def initialize responder_class
      super responder_class
      self.output=[]
    end

    def send msg,to
      @output << Message.new(msg,to)
    end

    def run script
      script.each do |text|
        handle Message.new(text,'test@localhost')
      end
    end
  end
end
