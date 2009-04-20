describe "ConsoleChannel commands" do
  before :each do
    setup_console
  end

  it "should respond to the .exit command" do
    @console.script=['a','.exit','b']
    @console.run

    @console.output.shift
    @console.output.should==['a']
  end

  it "should respond to .srand" do
    class << @console.responder_for 'console@localhost'
      def respond(msg) ; say rand(10) ; end
    end

    @console.script=['.srand 5','a']
    @console.run

    srand 5 ; num=rand(10)

    @console.output.shift
    @console.output.should==['Random seed is 5',
                             num]
  end

  it "should give an error on a bad command" do
    @console.script=['.fleeby']
    @console.run

    @console.output.shift
    @console.output.should==["Bad command .fleeby"]
  end

  it "should give an error on a good command with a bad arglist" do
    @console.script=['.srand apple']
    @console.run

    @console.output.shift
    @console.output.should==["Bad command .srand apple"]
  end

  it "should respond to .commands on/off" do
    @console.script=['.commands off','.exit','.commands on','.exit','a']
    @console.run

    @console.output.shift
    @console.output.should==['Commands are off',
                             '.exit',
                             'Commands are on']
  end

end
