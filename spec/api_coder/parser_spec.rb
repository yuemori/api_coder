require 'spec_helper'

describe APICoder::Parser do
  describe '#load' do
    subject { described_class.new.load(file_path) }

    let(:file_path) { File.expand_path '../../fixtures/user.conf', __FILE__ }

    it { expect { subject }.not_to raise_error }
  end
end
