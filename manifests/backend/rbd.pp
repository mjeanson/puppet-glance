#
# configures the storage backend for glance
# as a ceph pool
#
#  $rbd_store_user - Optional. Default: undef,
#
#  $rbd_store_pool - Optional. Default: 'images',
#
class glance::backend::rbd(
  $rbd_store_user = undef,
  $rbd_store_pool = 'images',
) {

  include glance::params

  glance_api_config {
    'DEFAULT/default_store':          value => 'rbd';
    'DEFAULT/rbd_store_user':         value => $rbd_store_user;
    'DEFAULT/rbd_store_pool':         value => $rbd_store_pool;
  }

  package { 'python-ceph':
    name   => $::glance::params::pyceph_package_name,
    ensure => $package_ensure,
  }
}
