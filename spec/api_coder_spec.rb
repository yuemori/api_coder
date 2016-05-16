require 'spec_helper'

describe APICoder do
  describe 'integration test' do
    subject { target_files.each { |f| load f } }

    let(:fixtures_path) { File.expand_path '../fixtures', __FILE__ }
    let(:target_files) { Dir.glob("#{fixtures_path}/**/*.conf") }

    it { expect { subject }.not_to raise_error }
  end
end
