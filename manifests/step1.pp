class chili_project::step1 {
# Step 1 clone source
  vcsrepo { chili_source:
    ensure   => present,
    path     => $chili_project::path,
    revision => $chili_project::version,
    source   => 'git://github.com/chiliproject/chiliproject.git',
    provider => git,
  }
}
