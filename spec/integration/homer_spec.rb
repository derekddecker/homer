require_relative '../spec_helper'
require 'homer/service/hue'

describe Homer do

  before :all do
    Homer.config do |homer|
      homer.define :labels => "lights", 
                   :locations => ["kitchen","living room"], 
                   :class => Homer::Hue
    end
  end

  describe :setting do
    let(:service) { Homer.settings.services.first }
    subject { service }
    it { should have_key(:labels) }
    it { should have_key(:locations) }
    it { should have_key(:class) }
  
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

    describe :class do
      subject { service[:class] }
      it { should be_a(Class) }
      it { should eq(Homer::Hue) }
      its(:ancestors) { should include(Homer::Service) }
    end
  end

end
