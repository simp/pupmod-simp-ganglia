require 'spec_helper'

describe 'ganglia::web' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { should compile.with_all_deps }
        it { should contain_package('gweb') }
        it { should contain_package('php') }
      end
    end
  end
end
