require 'rails_helper'

describe DateDependent do

  let(:dummy_class) do
    class DummyClass
      include DateDependent
    end

    DummyClass
  end

  let(:dummy_object) { dummy_class.new }

  before do
    allow(Date).to receive(:today) { Date.new(2014, 10, 9) }
  end

  it "returns the current year" do
    expect(dummy_object.current_year).to eq 2014
  end

  it "returns the next year" do
    expect(dummy_object.next_year).to eq 2015
  end

  it "returns the previous year" do
    expect(dummy_object.last_year).to eq 2013
  end

  it "returns the current month" do
    expect(dummy_object.current_month).to eq 10
  end
end
