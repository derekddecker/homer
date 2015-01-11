require_relative 'spec_helper'

describe CommandParser do
  
  let(:command_1) { "Lights on in master bedroom" }
  let(:command_2) { "Lights on in backyard" }
  let(:command_3) { "Temperature set to 76 degrees in house" }

  describe :command_1 do
    subject { CommandParser.parse(command_1) }
    its([0]) { should eq("lights") }
    its([1]) { should eq("on") }
    its([2]) { should eq("master bedroom") } 
    its([3]) { should eq("") }
  end

end
