require 'spec_helper'

describe 'ganglia::meta' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('ganglia-gmetad') }
        it { is_expected.to contain_package('ganglia-gmetad.i386').with_ensure('absent') }
        it { is_expected.to create_file('/etc/ganglia/gmetad.conf') }
      end
    end
  end
end
