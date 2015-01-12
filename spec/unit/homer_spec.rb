require_relative '../spec_helper'

describe Homer do

  subject { Homer }
  it { should respond_to(:config) }
  it { should respond_to(:settings) }
  it { should respond_to(:service_for_label) }
  it { should respond_to(:delegate) }
  its(:settings) { should be_a(Homer::Settings) }
  specify { expect { |b| subject.config(&b) }.to yield_control }
 
  describe :service_for_label do
    
    class TestClass < Homer::Service ; end

    before(:all) do 
      Homer.config do |c|
        c.define "label", TestClass
      end
    end

    context :existing_label do
      subject { lambda { Homer.service_for_label("label") } }
      it { should_not raise_exception }
      its(:call) { should eq(TestClass) }
    end

    context :missing_label do
      subject { lambda { Homer.service_for_label("missing_label") } }
      it { should raise_exception(Homer::UnknownServiceLabelException) }
    end

  end

  describe Homer::Settings do
    
    subject { Homer::Settings.new }
    it { should respond_to(:services) }
    it { should respond_to(:define) }
    its(:services) { should be_a(Hash) }

    context :define do
      class BadClass ; end
      class GoodClass < Homer::Service ; end

      context :valid_class do
        before(:all) do
          @test_settings = Homer::Settings.new
          @test_settings.define("label", GoodClass)
        end
        subject { @test_settings.services }
        it { should have_value(GoodClass) }
        it { should have_key("label") }
      end

      context :invalid_class do
        subject { lambda { @test_settings = Homer::Settings.new ; @test_settings.define("label", BadClass) } }
        it { should raise_exception(Homer::InvalidServiceException) }
      end
    end

  end 

end
