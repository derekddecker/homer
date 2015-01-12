require_relative '../spec_helper'

describe Homer::ServiceDelegator do

  describe :service_for_label_and_location do
    
    class TestClass < Homer::Service ; end

    before(:all) do 
      Homer.config do |c|
        c.define :labels => "label", :locations => "kitchen", :class => TestClass
      end
    end

    context :existing_label do
      subject { lambda { Homer::ServiceDelegator.service_for_label_and_location("label", "kitchen") } }
      it { should_not raise_exception }
      its(:call) { should eq(TestClass) }
    end

    context :missing_label do
      subject { lambda { Homer::ServiceDelegator.service_for_label_and_location("missing_label", "kitchen") } }
      it { should raise_exception(Homer::UnknownServiceLabelException) }
    end

  end

end
