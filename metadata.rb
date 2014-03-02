name             'sumologic-collector'
maintainer       'Ben Newton'
maintainer_email 'ben@sumologic.com'
license          'Apache v2.0'
description      'Installs/Configures sumologic-collector'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.00'
attribute 'accessId',
  :display_name => "Access ID",
  :type => "string",
  :required => "required"
attribute 'accessKey',
  :display_name => "Access Key",
  :type => "string",
  :required => "required"
