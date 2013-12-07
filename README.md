sumologic-collector Cookbook
============================
This cookbook will install either the 32-bit and 64-bit Sumo Logic Linux collector using the shell script installer (based on the CPU type). It first sets up the files required for an unattended install (sumo.conf and the JSON configuration file) with the standard linux system log files, downloads the latest installer, and then runs the installer. If the requirements are met, then the collector will automatically install and activate itself. The JSON template can be edited for your environment's specifications.

Requirements
------------
Most importantly, you need access to the following URL on each server:
  - https://collectors.sumologic.com

This will allow for activation and downloading the installer.

For additional requirements, see this URL:
  - https://service.sumologic.com/ui/help/Default.htm#Testing_Connectivity.htm

Attributes
----------

<table>
  <tr>
    <th>['sumologic']['useAccessID']</th>
    <th>String</th>
    <th>Flag to indicate whether you will use AccessID-Key or Email-Password for authentication</th>
    <th>Optional</th>
  </tr>
  <tr>
    <th>['sumologic']['userID']</th>
    <th>String</th>
    <th>Sumo Logic User ID</th>
    <th>Optional</th>
  </tr>
  <tr>
    <th>['sumologic']['password']</th>
    <th>String</th>
    <th>Sumo Logic Password</th>
    <th>Optional</th>
  </tr>
  <tr>
    <th>['sumologic']['accessID']</th>
    <th>String</th>
    <th>Sumo Logic Access ID</th>
    <th>Optional</th>
  </tr>
  <tr>
    <th>['sumologic']['accessKey']</th>
    <th>String</th>
    <th>Sumo Logic Access Key</th>
    <th>Optional</th>
  </tr>
  <tr>
    <th>['sumologic']['ephemeral']</th>
    <th>Boolean</th>
    <th>Sumo Logic Ephemeral Setting</th>
    <th>Required</th>
  </tr>
  <tr>
    <th>['sumologic']['sources']['default_timezone']</th>
    <th>String</th>
    <th>Timezone for source setup (defaults to UTC)</th>
    <th>Required</th>
  </tr>
  <tr>
    <th>['sumologic']['installDir'] </th>
    <th>String</th>
    <th>Sumo Logic Install Directory</th>
    <th>Required</th>
  </tr>
</table>

The following attributes are not required but can be used to define custom cookbooks and templates 
within a wrapper cookbook for generating custom sumo.conf and sumo.json configuration files.
<table>
  <tr>
    <th>['sumologic']['json_config_cookbook'] Default: sumologic-collector</th>
    <th>String</th>
    <th>User defined cookbook for generating custom sumo.json templates</th>
    <th>Not Required</th>
  </tr>
  <tr>
    <th>['sumologic']['json_template']</th>
    <th>String</th>
    <th>User defined sumo.json template name</th>
    <th>Not Required</th>
  </tr>
  <tr>
    <th>['sumologic']['conf_config_cookbook'] Default: sumologic-collector</th>
    <th>String</th>
    <th>User defined cookbook for generating custom sumo.conf templates</th>
    <th>Not Required</th>
  </tr>
  <tr>
    <th>['sumologic']['conf_template'] </th>
    <th>String</th>
    <th>User defined sumo.conf template name</th>
    <th>Not Required</th>
  </tr>
</table>

The following attributes are not required but can be used to define an encrypted data bag containing the authentication credentials. The data bag that this points to should have 'email' and 'password' keys containing the email address and password to use to authenticate this collector. 

<table>
  <tr>
    <th>['sumologic']['credentials']['bag_name']</th>
    <th>String</th>
    <th>Name of the data bag.</th>
    <th>Required</th>
  </tr>
  <tr>
    <th>['sumologic']['credentials']['item_name']</th>
    <th>String</th>
    <th>Name of the item within the data bag. </th>
    <th>Required</th>
  </tr>
  <tr>
    <th>['sumologic']['credentials']['secret_file']</th>
    <th>String</th>
    <th>Path to the local file containing the encryption secret key.</th>
    <th>Optional</th>
  </tr>
</table>



Usage
-----

Just include `sumologic-collector` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sumologic-collector]"
  ]
}
```

Contributing
------------
This cookbook is meant to help customers use chef to install Sumo Logic collectors, so please feel to fork this repository, and make whatever changes you need for your environment.


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com)
