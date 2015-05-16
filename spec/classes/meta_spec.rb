require 'spec_helper'

describe 'ganglia::meta' do
  base_facts = {
    :hardwaremodel => 'x86_64'
  }

  let(:facts) {base_facts}

  it { should contain_package('ganglia-gmetad') }
  it { should contain_package('ganglia-gmetad.i386').with_ensure('absent') }
  it { should create_file('/etc/ganglia/gmetad.conf') }
end
