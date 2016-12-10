require 'weapons/bow'

describe Bow do
  let(:default_bow){Bow.new}
  let(:twenty){Bow.new(20)}
  let(:empty_bow){Bow.new(0)}

  describe '#initialize' do
    it "returns arrow" do
      expect(Bow.new(33).arrows).to eq(33)
    end

    it "starts with 10 arrows by default" do
      expect(default_bow.arrows).to eq(10)
    end

    it "starts with number of arrows passed in as an argument" do
      expect(twenty.arrows).to eq(20)
    end
  end

  describe '#use' do
    it "reduces arrows by 1 when method is called" do
      twenty.use
      expect(twenty.arrows).to eq(19)
    end

    it "raises error when arrow count is 0" do
      expect{empty_bow.use}.to raise_error("Out of arrows")
    end
  end
end