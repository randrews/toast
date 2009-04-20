describe "ConsoleChannel basic functionality" do

  before :each do
    setup_console
  end

  it "should begin with a helpful message" do
    @console.run
    @console.output.should == ["Type .exit or ctrl-D to leave"]
  end

  it "should output whatever the responder does" do
    @console.script=['a','b']
    @console.run

    @console.output.shift
    # we know responder is an echo
    @console.output.should==['a','b']
  end
end
