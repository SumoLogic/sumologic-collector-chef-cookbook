name 'sumologic-collector'
maintainer 'Yoway Buorn'
maintainer_email 'yoway@sumologic.com'
issues_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook/issues'
source_url 'https://github.com/SumoLogic/sumologic-collector-chef-cookbook'
license 'Apache v2.0'
description 'Installs/Configures sumologic-collector'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.11'
attribute 'sumologic/credentials/bag_name',
  display_name: "Credentials bag name",
  type: "string",
  required: "required"
attribute 'sumologic/credentials/item_name',
  display_name: "Credentials item name",
  type: "string",
  required: "required"

%w(
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
).each do |os|
  supports os
end
