require 'spec_helper'

describe 'ganglia::monitor' do
  base_facts = {
    :hardwaremodel => 'x86_64'
  }

  let(:facts) {base_facts}

  it { should compile.with_all_deps }
  it { should create_file('/etc/ganglia/gmond.conf') }
end
