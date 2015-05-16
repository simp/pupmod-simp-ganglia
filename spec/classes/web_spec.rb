require 'spec_helper'

describe 'ganglia::web' do

  it { should contain_package('gweb') }
  it { should contain_package('php') }
end
