require 'spec_helper'

describe 'glance::backend::rbd' do
  let :facts do
    {
      :osfamily => 'Debian'
    }
  end

  let :pre_condition do
    'class { "glance::api": keystone_password => "pass" }'
  end

  it { should contain_glance_api_config('DEFAULT/default_store').with_value('rbd') }
  it { should contain_glance_api_config('DEFAULT/rbd_store_pool').with_value('images') }

  describe 'when overriding datadir' do
    let :params do
      {
        :rbd_store_user => 'user',
        :rbd_store_pool => 'pool',
      }
    end
    it { should contain_glance_api_config('DEFAULT/rbd_store_user').with_value('user') }
    it { should contain_glance_api_config('DEFAULT/rbd_store_pool').with_value('pool') }
  end
end
