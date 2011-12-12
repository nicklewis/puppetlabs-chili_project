chili_project
=============

Author: Nick Lewis <nick@puppetlabs.com>
Author: Deepak Giridharagopal <deepak@puppetlabs.com>
Copyright (c) 2011, Puppet Labs Inc.


ABOUT
=====

This module manages the [ChiliProject project management system] (http://www.chiliproject.org). There is a single, main class (`chili_project`) that will download, build, and install Chili from source. As there are no pre-built, system packages for the project, this is the "recommended" way to get things up-and-running.


REQUIREMENTS
============

 * Puppet >=2.7 if using parameterized classes
 * Git

   You can use the `puppetlabs/git` module, from the Puppet Module Forge

 * vcsrepo

   You can use the `puppetlabs/vcsrepo` module, from the Puppet Module Forge

 * Ruby >=1.8.7 and Rubygems

   You can use the `puppetlabs/ruby` module, from the Puppet Module Forge, for this on most modern Linux distributions

 * Bundler

   You can use the included `chili_project::prereqs::bundler` class to install this using Rubygems

 * Ruby-Imagemagick bindings

   You can use the included `chili_project::prereqs:ruby_magick` class to install this from system packages

 * Ruby-MySQL bindings

   You can use the included `chili_project::prereqs:ruby_mysql` class to install this from system packages

 * A MySQL installation (you must tell us the host, port, database name, user, and password to use for chili)

CONFIGURATION
=============

Here is a simple example that will install, build, and configure Chili:

```puppet
  class { 'chili_project':
    version => 'v2.5.0',
    path => '/opt/chiliproject',
    db_adapter => 'mysql',
    db_pass => 'SooperSekret',
  }
```

By itself, this doesn't do much; you still need to provide a method of running this code as a daemon. We've included a class, `chili_project::service::unicorn`, that will install the `unicorn` application server and start it up on the port you specify, pointing it at your installation of Chili.

Here is a more complete example of code that will use modules from the Puppet Forge for `ruby` and `git`, uses our included `prereq` classes, and our included `unicorn` service class:

```puppet
  class prereqs {
    include ruby
    include git
    include chili_project::prereqs::bundler
    include chili_project::prereqs::ruby_magick
    include chili_project::prereqs::ruby_mysql

    Class[ruby] -> Class[chili_project::prereqs::bundler]
    Class[ruby] -> Class[chili_project::prereqs::ruby_magick]
  }

  class chili {
    include prereqs

    class { chili_project:
      version => 'v2.5.0',
      path => '/opt/chiliproject',
      db_adapter => 'mysql',
      db_host => 'my-database-host.com',
      db_port => 3306,
      db_user => 'chili',
      db_pass => 'chili',
    }

    class { chili_project::service::unicorn:
      app_root => '/opt/chiliproject',
    }

    Class[prereqs] -> Class[chili_project]
  }

  node "my-chili-project-host.com" {
    include chili
  }
```

TODO
====

 * Add adapters for more database types
 * Modify prereq classes to be more OS-neutral, if possible
