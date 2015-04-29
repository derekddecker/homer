require_relative '../spec_helper'

describe Homer do

  subject { Homer }
  it { should respond_to(:config) }
  it { should respond_to(:settings) }
  it { should respond_to(:delegate) }
  its(:settings) { should be_a(Homer::Settings) }
  specify { expect { |b| subject.config(&b) }.to yield_control }

end
