require_relative 'spec_helper'

describe CommandParser do
  
  let(:command_1) { "Lights on in master bedroom" }
  let(:command_2) { "Lights on in backyard" }
  let(:command_3) { "Temperature set to 76 degrees in house" }

  describe :command_1 do
    subject { CommandParser.parse(command_1) }
    its(:service) { should eq("lights") }
    its(:action) { should eq("on") }
    its(:location) { should eq("master bedroom") } 
    its(:settings) { should eq("") }
  end

end
