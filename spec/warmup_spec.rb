require 'warmup'

describe Warmup do
  let(:user){Warmup.new}

  describe '#gets_shout' do
    it "returns gets input capitalized" do
      allow(user).to receive(:gets).and_return("something")
      expect(user.gets_shout).to eq("SOMETHING")
    end

    it "puts input capitalized" do
      allow(user).to receive(:gets).and_return("something")
      expect(STDOUT).to receive(:puts).with("SOMETHING")
      user.gets_shout
    end
  end

  describe '#triple_size' do
    let(:argument){double(size: 10)}
    
    it "returns something when passed argument" do
      expect(user.triple_size(argument)).to eq(30)
    end
  end

  describe '#calls_some_methods' do
    it "passed in string receives upcase method call" do
      string = "something"
      expect(string).to receive(:upcase!).and_return("SOMETHING")
      user.calls_some_methods(string)
    end

    it "passed in string receives reverse method call" do
      string = "string"
      expect(string).to receive(:reverse!).and_return("GNIHTEMOS")
      user.calls_some_methods(string) 
    end

    it "returns a different object than the one passed in" do
      string = "something"
      expect(string.object_id).not_to eq(user.calls_some_methods(string).object_id)
    end
  end




end