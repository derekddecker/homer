require_relative '../spec_helper'

describe Homer::Controller do

  class TestController < Homer::Controller 
    def set ; end
  end
  let(:service_hash) { { :controller => TestController, :labels => "temperature", :locations => "bedroom" } }
  let(:services) { services = Homer::ServiceList.new ; services << service_hash }
  let(:mock_command) { Homer::CommandParser.new(:phrase => "set temperature to 76 degrees in the bedroom", :services => services) }
  let(:homer_controller) { TestController }
  subject { homer_controller }
  
  it { should respond_to(:actions) }
  its(:actions) { should eq([:set]) }

  describe :api_fqdn do
    subject { lambda{ homer_controller.api_fqdn } }
    it { should raise_exception(NotImplementedError) }
  end

  context :instantiated do

    subject { homer_controller.new(mock_command) }

    it { should respond_to(:command) }
    its(:command) { should respond_to(:locations) }
    its(:command) { should respond_to(:settings) }

    describe :command do
      subject { homer_controller.new(mock_command).command }
      its(:locations) { should include("bedroom") }
      its(:settings) { should eq("to 76 degrees") }
    end

  end

end
