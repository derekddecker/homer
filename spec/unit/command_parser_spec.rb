require_relative '../spec_helper'

describe Homer::CommandParser do
  
  let(:command_1) { "Lights on in master bedroom" }
  let(:command_2) { "Lights on in backyard" }
  let(:command_3) { "Temperature set to 76 degrees in house" }

  describe :command_1 do
    subject { Homer::CommandParser.parse(command_1) }
    its(:label) { should eq("lights") }
    its(:action) { should eq("on") }
    its(:location) { should eq("master bedroom") } 
    its(:settings) { should eq("") }
  end

  describe :command_2 do
    subject { Homer::CommandParser.parse(command_2) }
    its(:label) { should eq("lights") }
    its(:action) { should eq("on") }
    its(:location) { should eq("backyard") } 
    its(:settings) { should eq("") }
  end

  describe :command_3 do
    subject { Homer::CommandParser.parse(command_3) }
    its(:label) { should eq("temperature") }
    its(:action) { should eq("set") }
    its(:location) { should eq("house") } 
    its(:settings) { should eq("to 76 degrees") }
  end

end
