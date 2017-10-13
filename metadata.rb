# frozen_string_literal: true

name 'sumologic-collector'
maintainer 'Sumo Logic'
maintainer_email 'opensource@sumologic.com'
issues_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook' if respond_to?(:source_url)
license 'Apache-2.0'
description 'Installs/Configures sumologic-collector'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.23'
chef_version '>= 11' if respond_to?(:chef_version)

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
