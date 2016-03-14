require 'spec_helper'

describe 'ganglia::web' do

  it { should compile.with_all_deps }
  it { should contain_package('gweb') }
  it { should contain_package('php') }
end
