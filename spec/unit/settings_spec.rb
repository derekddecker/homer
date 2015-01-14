require_relative '../spec_helper'

describe Homer::Settings do
  
  subject { Homer::Settings.new }
  it { should respond_to(:services) }
  it { should respond_to(:define) }
  its(:services) { should be_a(Array) }

  context :define do
    class BadClass ; end
    class GoodClass < Homer::Controller ; end

    context :valid_class do
      before(:all) do
        @test_settings = Homer::Settings.new
        @test_settings.define(:labels => "label", :locations => "kitchen", :controller => GoodClass)
      end
      subject { @test_settings.services }
      it { should be_a(Array) }

      describe GoodClass do
        subject { @test_settings.services.first }
        it { should have_key(:labels) }
        it { should have_key(:locations) }
        it { should have_key(:controller) }

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
        
        describe :controller do
          subject { @test_settings.services.first[:controller] }
          it { should be_a(Class) }
          it { should eq(GoodClass) }
          its(:ancestors) { should include(Homer::Controller) }
        end
      end
    end

    context :invalid_class do
      subject { lambda { @test_settings = Homer::Settings.new ; @test_settings.define(:labels => "label", :locations => "one", :controller => BadClass) } }
      it { should raise_exception(Homer::InvalidServiceException) }
    end

  end

end
