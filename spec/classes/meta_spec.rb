require 'spec_helper'

describe 'ganglia::meta' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { should compile.with_all_deps }
        it { should contain_package('ganglia-gmetad') }
        it { should contain_package('ganglia-gmetad.i386').with_ensure('absent') }
        it { should create_file('/etc/ganglia/gmetad.conf') }
      end
    end
  end
end
