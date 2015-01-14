require_relative '../spec_helper'

describe Homer::ServiceList do

  describe :service_for_label_and_location do
    
    class TestClass < Homer::Controller ; end

    before(:all) do 
      Homer.config do |c|
        c.define :labels => "label", :locations => "kitchen", :controller => TestClass
      end
    end

    context :existing_label do
      subject { lambda { Homer.services.service_for_label_and_location("label", "kitchen") } }
      it { should_not raise_exception }
      its(:call) { should eq(TestClass) }
    end

    context :missing_label do
      subject { lambda { Homer.services.service_for_label_and_location("missing_label", "kitchen") } }
      it { should raise_exception(Homer::UnknownServiceLabelException) }
    end

  end

end
