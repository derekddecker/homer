require_relative '../spec_helper'

describe Homer do

  subject { Homer }
  it { should respond_to(:config) }
  it { should respond_to(:settings) }
  it { should respond_to(:delegate) }
  its(:settings) { should be_a(Homer::Settings) }
  specify { expect { |b| subject.config(&b) }.to yield_control }
 
  describe Homer::Settings do
    
    subject { Homer::Settings.new }
    it { should respond_to(:services) }
    it { should respond_to(:define) }
    its(:services) { should be_a(Array) }

    context :define do
      class BadClass ; end
      class GoodClass < Homer::Service ; end

      context :valid_class do
        before(:all) do
          @test_settings = Homer::Settings.new
          @test_settings.define(:labels => "label", :locations => "kitchen", :class => GoodClass)
        end
        subject { @test_settings.services }
        it { should be_a(Array) }

        describe GoodClass do
          subject { @test_settings.services.first }
          it { should have_key(:labels) }
          it { should have_key(:locations) }
          it { should have_key(:class) }

          describe :labels do
            subject { @test_settings.services.first[:labels] }
            it { should be_a(Array) }
            it { should include("label") }
          end

          describe :locations do
            subject { @test_settings.services.first[:locations] }
            it { should be_a(Array) }
            it { should include("kitchen") }
          end
          
          describe :class do
            subject { @test_settings.services.first[:class] }
            it { should be_a(Class) }
            it { should eq(GoodClass) }
            its(:ancestors) { should include(Homer::Service) }
          end
        end
      end

      context :invalid_class do
        subject { lambda { @test_settings = Homer::Settings.new ; @test_settings.define(:labels => "label", :locations => "one", :class => BadClass) } }
        it { should raise_exception(Homer::InvalidServiceException) }
      end

      context :missing_settings do 
        subject { lambda { @test_settings = Homer::Settings.new ; @test_settings.define(:locations => "one", :class => BadClass) } }
        it { should raise_exception(Homer::MissingSetting) }
      end
    end

  end 

end
