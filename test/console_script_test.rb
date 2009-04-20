describe "ConsoleChannel .script command" do

  before :each do
    setup_console
  end

  before :all do
    @res_dir=File.expand_path(File.dirname(__FILE__)+'/resources')
  end

  it "should respond to .script" do
    @console.script=['first',".script #{@res_dir}/console_1.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['first', 'a','b']
  end

  it "should allow scripts to run commands" do
    @console.script=[".script #{@res_dir}/console_2.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['Random seed is 5']
  end

  it "should allow scripts to run .exit" do
    @console.script=[".script #{@res_dir}/console_3.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['a']
  end

  it "should allow scripts to call scripts" do
    @console.script=[".script #{@res_dir}/console_4_a.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['a-1','b-1','a-2']
  end

  it "should allow second-level scripts to .exit" do
    @console.script=[".script #{@res_dir}/console_5_a.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['a-1','b-1']
  end

  it "should ignore blank/whitespace lines in scripts" do
    @console.script=[".script #{@res_dir}/console_6.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['a-1','a-2','a-3']
  end

  it "should ignore lines that begin with #" do
    @console.script=[".script #{@res_dir}/console_7.txt"]
    @console.run

    @console.output.shift
    @console.output.should==['a-1','a-2','a-3']
  end

end
