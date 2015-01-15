require_relative '../spec_helper'

describe Homer::CommandParser do
 
  class TestService < Homer::Controller
    def on ; end
    def set ; end
  end

  before :all do
    Homer.config do |config|
      config.define :labels => ["lights"], :locations => ["kitchen", "bedroom", "master bedroom"], :controller => TestService
      config.define :labels => ["temperature","heater","air conditioning"], :locations => ["house"], :controller => TestService
      config.define :labels => ["temperature","heater","lights"], :locations => ["pool", "spa", "hot tub", "backyard"], :controller => TestService
    end
  end

  let(:service_list) { Homer.settings.services } 

  shared_examples_for :command_parser_common do
    it { should respond_to(:parse!) }
    it { should respond_to(:parse_locations) }
  end

  shared_examples_for :command_parser do
    context :command_1 do
      subject { Homer::CommandParser.new(:phrase => command_1, :services => service_list) }
      it_behaves_like :command_parser_common
      its(:labels) { should include("lights") }
      its(:action) { should include("on") }
      its(:locations) { should include("master bedroom") } 
      its(:settings) { should eq("") }
    end

    context :command_2 do
      subject { Homer::CommandParser.new(:phrase => command_2, :services => service_list) }
      it_behaves_like :command_parser_common
      its(:labels) { should include("lights") }
      its(:action) { should include("on") }
      its(:locations) { should include("backyard") } 
      its(:settings) { should eq("") }
    end

    context :command_3 do
      subject { Homer::CommandParser.new(:phrase => command_3, :services => service_list) }
      it_behaves_like :command_parser_common
      its(:labels) { should include("temperature") }
      its(:action) { should include("set") }
      its(:locations) { should include("house") } 
      its(:settings) { should eq("to 76 degrees") }
    end

    context :command_4 do
      subject { Homer::CommandParser.new(:phrase => command_4, :services => service_list) }
      it_behaves_like :command_parser_common
      its(:labels) { should include("temperature") }
      its(:action) { should include("set") }
      its(:locations) { should include("house") } 
      its(:locations) { should include("pool") }
      its(:settings) { should eq("to 76 degrees") }
    end
  end

  context :convention_1 do
    let(:command_1) { "Lights on in master bedroom" }
    let(:command_2) { "Lights on in backyard" }
    let(:command_3) { "Temperature set to 76 degrees in house" }
    let(:command_4) { "Temperature set to 76 degrees in house and the pool" }
    it_behaves_like :command_parser
  end

  context :convention_2 do
    let(:command_1) { "Turn on the lights in the master bedroom" }
    let(:command_2) { "Turn lights on in backyard" }
    let(:command_3) { "Set the temperature to 76 degrees in the house" }
    let(:command_4) { "Set the temperature to 76 degrees in the house and pool" }
    it_behaves_like :command_parser
  end

  context :convention_3 do
    let(:command_1) { "Master bedroom lights on" }
    let(:command_2) { "Backyard lights on" }
    let(:command_3) { "House temperature set to 76 degrees" }
    let(:command_4) { "House and pool temperature set to 76 degrees" }
    it_behaves_like :command_parser
  end

end
