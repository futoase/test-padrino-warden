require 'spec_helper'

describe "TestPadrinoWarden::App::IndexHelper" do
  let(:helpers){ Class.new }
  before { helpers.extend TestPadrinoWarden::App::IndexHelper }
  subject { helpers }

  it "should return nil" do
    expect(subject.foo).to be_nil
  end
end
