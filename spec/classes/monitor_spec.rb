require 'spec_helper'

describe 'ganglia::monitor' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { should compile.with_all_deps }
        it { should create_file('/etc/ganglia/gmond.conf') }
      end
    end
  end
end
