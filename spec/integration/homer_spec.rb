require_relative '../spec_helper'
require 'homer/service/hue'

describe Homer do

  before :all do
    Homer.config do |homer|
      homer.define "lights", Homer::Hue
    end
  end

  it "should have settings contained in module" do
    expect(Homer.settings.services["lights"]).to eq(Homer::Hue)
  end 

end
