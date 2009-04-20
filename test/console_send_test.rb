describe "ConsoleChannel .send command" do

  before :each do
    setup_console
  end

  it "should respond to .send" do
    class << @console.responder_for 'console@localhost'
      attr_accessor :word
      def respond msg ; @word ; end
    end

    @console.script=['.send word= blah','a']
    @console.run

    @console.output.shift
    @console.output.should==['blah','blah'] # twice because .send returns it
  end


  it "should give an error on a bad command" do
    @console.script=['.send mxyzptlk']
    @console.run

    @console.output.shift
    @console.output[0].should=~/undefined method/
  end

  it "should return nothing if the command returns nil" do
    class << @console.responder_for 'console@localhost'
      def nada ; nil ; end
    end

    @console.script=['a','.send nada','b']
    @console.run

    @console.output.shift
    @console.output.should==['a','b']
  end
end
