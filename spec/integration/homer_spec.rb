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
    subject { Homer.settings.services[Homer::Hue] }
    it { should have_key(:labels) }
    it { should have_key(:locations) }
  
    describe :labels do
      subject { Homer.settings.services[Homer::Hue][:labels] }
      it { should be_a(Array) }
      it { should include("lights") }
    end

    describe :locations do
      subject { Homer.settings.services[Homer::Hue][:locations] }
      it { should be_a(Array) }
      it { should include("kitchen") }
      it { should include("living room") }
    end
  end

end
