require_relative '../spec_helper'

describe Homer do
  
  class TestController < Homer::Controller ; end

  before :all do
    Homer.config do |homer|
      homer.define :labels => "lights", 
                   :locations => ["kitchen","living room"], 
                   :controller => TestController
    end
  end

  describe :setting do
    let(:service) { Homer.settings.services.first }
    subject { service }
    it { should have_key(:labels) }
    it { should have_key(:locations) }
    it { should have_key(:controller) }
  
    describe :labels do
      subject { service[:labels] }
      it { should be_a(Array) }
      it { should include("lights") }
    end

    describe :locations do
      subject { service[:locations] }
      it { should be_a(Array) }
      it { should include("kitchen") }
      it { should include("living room") }
    end

    describe :controller do
      subject { service[:controller] }
      it { should be_a(Class) }
      it { should eq(TestController) }
      its(:ancestors) { should include(Homer::Controller) }
    end
  end

end
