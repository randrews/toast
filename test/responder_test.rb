describe Toast::Responder do
  before :each do
    @channel=Toast::TestChannel.new Toast::Responder
  end

  it "should handle a single message" do
    @channel.handle Toast::Message.new('foo','test@localhost')
    @channel.output[0].text.blank?.should == false
  end

  it "should be able to send messages" do
    class << @channel.responder_for('test@localhost')
      def respond msg
        say 'a'
        say 'b'
        say 'c'
      end
    end

    @channel.handle Toast::Message.new('x','test@localhost')

    @channel.output[0].text.should == 'a'
    @channel.output[1].text.should == 'b'
    @channel.output[2].text.should == 'c'
  end

  it "waiting for messages shouldn't send anything" do
    class << @channel.responder_for('test@localhost')
      def respond msg
        msg2=wait
        say msg2
      end
    end

    @channel.handle Toast::Message.new('a','test@localhost')
    @channel.output.empty?.should == true
  end

  it "should be able to wait for messages" do
    class << @channel.responder_for('test@localhost')
      def respond msg
        msg2=wait
        say msg2
      end
    end

    @channel.handle Toast::Message.new('a','test@localhost')
    @channel.handle Toast::Message.new('b','test@localhost')
    @channel.output[0].text.should == 'b'
  end

  it "should say whatever it returns" do
    class << @channel.responder_for('test@localhost')
      def respond msg
        'foo'
      end
    end

    @channel.handle Toast::Message.new('a','test@localhost')
    @channel.output[0].text.should == 'foo'
  end

  it "shouldn't say anything on returning nil" do
    class << @channel.responder_for('test@localhost')
      def respond msg
        nil
      end
    end

    @channel.handle Toast::Message.new('a','test@localhost')
    @channel.output.empty?.should == true
  end

  it "should keep sessions separate" do
    @channel.responder_class.class_eval do
      def respond msg
        say "1: #{msg}"
        say "2: #{wait}"
      end
    end

    @channel.handle Toast::Message.new('a1','a')
    @channel.handle Toast::Message.new('b1','b')

    @channel.output.map(&:from).should == ['a','b']
    @channel.output.map(&:text).should == ['1: a1',
                                           '1: b1']
  end

  it "should be able to wait after saying" do
    class << @channel.responder_for('test')
      def respond msg
        say "1: #{msg}"
        "2: #{wait}"
      end
    end

    @channel.handle Toast::Message.new('a','test')
    @channel.handle Toast::Message.new('b','test')

    @channel.output.map(&:text).should == ['1: a',
                                           '2: b']
  end

  it "should restart after respond returns" do
    class << @channel.responder_for('test')
      def respond(msg)
        say "1: #{msg}"
        "2: #{wait}"
      end
    end

    @channel.handle Toast::Message.new('a','test')
    @channel.handle Toast::Message.new('b','test')
    @channel.handle Toast::Message.new('c','test')

    @channel.output.map(&:text).should == ['1: a',
                                           '2: b',
                                           '1: c']
  end

end
