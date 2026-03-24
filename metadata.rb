# frozen_string_literal: true

name 'sumologic-collector'
maintainer 'Sumo Logic'
maintainer_email 'collection@sumologic.com'
issues_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook/issues'
source_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook'
description 'Installs/Configures sumologic-collector'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.9.1'
chef_version '>= 12.5'
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
