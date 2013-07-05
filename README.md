glance
=======

#### Table of Contents

1. [Overview - What is the glance module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with glance](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------

The glance module is a part of [Stackforge](https://github.com/stackfoge), an effort by the Openstack infrastructure team to provide continuous integration testing and code review for Openstack and Openstack community projects not part of the core software.  The module its self is used to flexibly configure and manage the image service for Openstack.

Module Description
------------------

The glance module is a thorough attempt to make Puppet capable of managing the entirety of glance.  This includes manifests to provision such things as keystone endpoints, RPC configurations specific to glance, and database connections.  Types are shipped as part of the glance module to assist in manipulation of configuration files.

This module is tested in combination with other modules needed to build and leverage an entire Openstack software stack.  These modules can be found, all pulled together in the [openstack module](https://github.com/stackfoge/puppet-openstack).

Setup
-----

**What the glance module affects**

* glance, the image service for Openstack.

### Installing glance

    example% puppet module install puppetlabs/glance

### Beginning with glance

To utilize the glance module's functionality you will need to declare multiple resources.  The following is a modified excerpt from the [openstack module](https://github.com/stackfoge/puppet-openstack).  This is not an exhaustive list of all the components needed, we recommend you consult and understand the [openstack module](https://github.com/stackforge/puppet-openstack) and the [core openstack](http://docs.openstack.org) documentation.

**Define a glance node**

```puppet
class { 'glance::api':
  verbose           => 'True',
  keystone_tenant   => 'services',
  keystone_user     => 'glance',
  keystone_password => '12345',
  sql_connection    => 'mysql://glance:12345@127.0.0.1/glance',
}

class { 'glance::registry':
  verbose           => 'True',
  keystone_tenant   => 'services',
  keystone_user     => 'glance',
  keystone_password => '12345',
  sql_connection    => 'mysql://glance:12345@127.0.0.1/glance',
}

class { 'glance::backend::file': }
```

**Setup postgres node glance**

```puppet
class { 'glance::db::postgresql':
  password => '12345',
}
```

**Setup mysql node for glance**

```puppet
class { 'glance::db::mysql':
  password      => '12345',
  allowed_hosts => '%',
}
```

**Setup up keystone endpoints for glance on keystone node**

```puppet
class { 'glance::keystone::auth':
  password         => '12345'
  public_address   => '172.17.0.3',
  admin_address    => 'admin@example.com',
  internal_address => '172.17.1.3',
  region           => 'example-west-1',
}
```

Implementation
--------------

### glance

glance is a combination of Puppet manifest and ruby code to deliver configuration and extra functionality through types and providers.

Limitations
------------

* Only supports configuring the file, swift and rbd storage backends.

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://wiki.openstack.org/wiki/Puppet-openstack#Developer_documentation

Contributors
------------

* https://github.com/stackforge/puppet-glance/graphs/contributors

Release Notes
-------------

**next**

* Added rbd backend support.

**2.0.0**

* Upstream is now part of stackfoge.
* Added postgresql support.
* Various cleanups and bug fixes.
