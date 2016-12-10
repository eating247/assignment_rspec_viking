require 'viking'
require 'pry'

describe Viking do
    let(:blade){Weapon.new("Blade")}
    let(:new_blade){Weapon.new("NewNew")}    
    let(:default_viking){Viking.new}
    let(:customized_viking){Viking.new("Vik",1000,10,blade)}


  describe '#initialize' do
    it "sets passed in name to name attribute" do
      expect(customized_viking.name).to eq("Vik")
    end

    it "sets passed in health to health attribute" do
      expect(customized_viking.health).to eq(1000)
    end

    it "cannot change health attribute after set" do
      expect{customized_viking.health = 20}.to raise_error(NoMethodError)
    end

    it "has a default nil weapon" do
      expect(default_viking.weapon).to be nil
    end
  end

  describe '#pick_up_weapon' do
    it "sets passed in weapon as weapon attribute" do
      default_viking.pick_up_weapon(blade)
      expect(default_viking.weapon).to eq(blade)
    end

    it "raises error if argument is non-weapon" do
      expect{default_viking.pick_up_weapon(nil)}.to raise_error("Can't pick up that thing")
    end

    it "replaces weapon when picking up new weapon" do
      default_viking.pick_up_weapon(blade)
      default_viking.pick_up_weapon(new_blade)
      expect(default_viking.weapon).to eq(new_blade)
    end
  end

  describe '#drop_weapon' do
    it "leaves Viking weaponless" do
      default_viking.drop_weapon
      expect(default_viking.weapon).to be nil
    end
  end

  describe '#receive_attack' do
    it "reduces Viking health by specified amount" do
      default_viking.receive_attack(10)
      expect(default_viking.health).to be(90)
    end

    it "calls the take_damage method" do
      expect(default_viking).to receive(:take_damage)
      default_viking.receive_attack(10)
    end
  end

  describe '#attack' do
    it "causes recipient's health to drop" do
      default_viking.attack(customized_viking)
      expect(customized_viking.health).to be < 1000
    end

    it "calls recipient's take_damage method" do
      expect(customized_viking).to receive(:take_damage)
      default_viking.attack(customized_viking)
    end

    it "runs damage_with_fists when attacker has no weapons" do 
      expect(default_viking).to receive(:damage_with_fists).and_return(2.5)
      default_viking.attack(customized_viking)
    end

    it "attacking without weapons deals damage equal to Fists multiplier times strength " do
      expect(customized_viking).to receive(:receive_attack).with(2.5)
      default_viking.attack(customized_viking)
    end

    it "runs damage_with_weapon when attacker has weapons" do
      expect(customized_viking).to receive(:damage_with_weapon).and_return(10) 
      customized_viking.attack(default_viking)
    end

    it "deals damage equal to Viking strength times Weapon multiplier when attacking with weapon" do
      expect(default_viking).to receive(:receive_attack).with(10)
      customized_viking.attack(default_viking)
    end

    it "uses fists if attacking using a Bow without enough arrows" do
      bow = Bow.new(0)
      archer = Viking.new("Sterling",100,10,bow)
      expect(archer).to receive(:damage_with_fists).and_return(2.5)
      archer.attack(default_viking)
    end

    it "raises error when a Viking is killed" do
      beast = Viking.new("Rock",1000,1000,blade)
      expect{beast.attack(default_viking)}.to raise_error("RandomViking has Died...")
    end
  end




# class ends here
end