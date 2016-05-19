require 'spec_helper'

describe APICoder::Registry do
  subject { described_class.new(:Test) }

  it { should delegate_method(:key?).to(:items) }
  it { should delegate_method(:clear).to(:items) }
  it { should delegate_method(:find).to(:values) }
  it { should delegate_method(:each).to(:values) }

  it 'should alias #registerd? to #key?' do
    expect(subject.method(:registered?)).to eq subject.method(:key?)
  end
end
