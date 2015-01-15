require_relative '../spec_helper'

describe Homer::ServiceList do
    
  class TestClass < Homer::Controller
    def action ; end
  end

  before(:all) do 
    Homer.config do |c|
      c.define :labels => "label", :locations => "kitchen", :controller => TestClass
    end
  end

  let(:services) { Homer.services }
  subject { services }

  it { should respond_to(:service_for_label_and_location) }
  it { should respond_to(:actions) }
  it { should respond_to(:labels) }
  it { should respond_to(:locations) }
  it { should respond_to(:collect_uniq_for_key) }

  describe :service_for_label_and_location do

    context :existing_label do
      subject { lambda { services.service_for_label_and_location("label", "kitchen") } }
      it { should_not raise_exception }
      its(:call) { should eq(TestClass) }
    end

    context :missing_label do
      subject { lambda { services.service_for_label_and_location("missing_label", "kitchen") } }
      it { should raise_exception(Homer::UnknownServiceLabelException) }
    end

  end

  describe :actions do
    subject { services.actions }
    it { should be_a(Array) }
    it { should include("action") }
  end

  describe :labels do
    subject { services.labels }
    it { should be_a(Array) }
    it { should include("label") }
  end

  describe :locations do
    subject { services.locations }
    it { should be_a(Array) }
    it { should include("kitchen") }
  end

end
