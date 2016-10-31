require 'spec_helper'

describe 'ganglia::web::conf' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_concat_build('gweb') }
        it { is_expected.to contain_file('/usr/local/apache/ganglia-passwords').that_requires('Concat_build[gweb]') }
      end
    end
  end
end
