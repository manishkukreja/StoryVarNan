class RSpecGreeter
  def greet
  	"Hello RSpec"
  end
end


describe "RSpec Greeter" do
  it "should say 'hello RSpec!' when it receives the great() message" do
  	greeter = RSpecGreeter.new
  	greeting = greeter.greet
  	greeting.should == "Hello RSpec"
  end  	
end