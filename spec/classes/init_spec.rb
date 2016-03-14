require 'spec_helper'

describe 'ganglia' do

  it { should compile.with_all_deps }
  it { should create_class('ganglia') }
  it { should create_file('/etc/ganglia').with_ensure('directory') }
end
