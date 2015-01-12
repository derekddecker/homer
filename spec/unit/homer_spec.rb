require_relative '../spec_helper'

describe Homer do

  subject { Homer }
  it { should respond_to(:config) }
  it { should respond_to(:settings) }
  its(:settings) { should be_a(Homer::Settings) }
  specify { expect { |b| subject.config(&b) }.to yield_control }
 
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
