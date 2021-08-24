# frozen_string_literal: true

name 'sumologic'
maintainer 'Sumo Logic'
maintainer_email 'collection@sumologic.com'
license 'Apache-2.0'
version '0.0.0'
chef_version '>= 11' if respond_to?(:chef_version)
depends 'sumologic-collector', '>= 1.6.0'

%w[
  debian
  ubuntu
  centos
  redhat
  scientific
  fedora
  amazon
  oracle
  windows
  suse
].each do |os|
  supports os
end
