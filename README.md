sumologic-collector Cookbook
============================
[![Cookbook Version](https://img.shields.io/cookbook/v/sumologic-collector.svg?style=flat)](https://supermarket.chef.io/cookbooks/sumologic-collector)
[![Build Status](https://travis-ci.org/SumoLogic/sumologic-collector-chef-cookbook.svg?branch=master)](https://travis-ci.org/SumoLogic/sumologic-collector-chef-cookbook)
[![Build Status](https://jenkins-01.eastus.cloudapp.azure.com/job/sumologic-collector-cookbook/badge/icon)](https://jenkins-01.eastus.cloudapp.azure.com/job/sumologic-collector-cookbook/)

This cookbook installs the Sumo Logic collector or updates an existing one if it was set to use [Local Configuration Mangement](https://help.sumologic.com/Send_Data/Local_Configuration_File_Management). Installation on Linux uses the shell script
installer and on Windows uses the exe installer. Here are the steps it follows:

1. Sets up `sumo.conf` and `sumo.json` (or the json folder). By default the standard Linux logs (system and security) are captured. On Windows the application and system event logs are captured.
2. Downloads latest installer
3. Runs installer
4. Starts collector and registers with the Sumo Logic service

For collector update, the existing collector must have been switched to use Local Configuration Mangement - see the instructions to
configure [New Collectors](https://help.sumologic.com/Send_Data/Local_Configuration_File_Management/Local_File_Configuration_Management_for_New_Collectors_and_Sources)
or [Existing Collectors](https://help.sumologic.com/Send_Data/Local_Configuration_File_Management/Local_Configuration_File_Management_for_Existing_Collectors_and_Sources)
for more details. The steps the cookbook follows:

1. Verify that the collector folder exists.
2. (Optional) Recreate `sumo.conf` and `sumo.json` (or the json files under the json folder).
3. Restart the collector for the changes to take effect.   

The collector Requires outbound access to https://collectors.sumologic.com.
Edit `sumo.json` (or the json files under the json folder) to add/edit/remove sources.  After installation you can
[test connectivity](http://help.sumologic.com/Send_Data/Installed_Collectors/Step_1._Prepare_to_Install_Collectors/03Test_Connectivity).


Note
------
Starting from 19.107, there are 2 major extensions to SumoLogic collectors:
* You can configure a collector's parameters from a set of json files under a common folder. Each of the json file will represent a source on that collector. Updates made to a json file will then be reflected on its corresponding source. Note that the format of this kind of file is **slightly different** from that of the traditional single json file (sumo.json) and they are **not** compatible. You also need to use the parameter `syncSources` instead of `sources` inside `sumo.conf`.
See more details [here](https://help.sumologic.com/Send_Data/Installed_Collectors/sumo.conf).
* You can change a collector's existing parameters through local configuration json file(s) continuously. Before this, using collector API was the only option.
More information about this is [here](https://help.sumologic.com/Send_Data/Local_Configuration_File_Management)

Installation
------------
1. Create an [Access Key](http://help.sumologic.com/Manage/Security/Access_Keys)
2. Install the cookbook in your Chef repo (your knife version should be at least 11.10.4 and you should have the [knife github plugin](https://github.com/websterclay/knife-github-cookbooks) installed):

  ```
  knife cookbook github install SumoLogic/sumologic-collector-chef-cookbook
  ```
3. Specify data bag and item with your access credentials.  The data item should
contain attributes `accessID` and `accessKey`.  Note that attribute names are case sensitive.  If the cases mismatch, the values will not appear when chef-client runs.  The default data bag/item is
`['sumo-creds']['api-creds']`
4. (Optional) Decide if you want to use the Local Configuration Management feature by setting the attribute `default['sumologic']['local_management']` properly. By default this feature is on, to leverage the power of Chef.
5. (Optional) Select the json configuration option (i.e. through a single file or a folder) by setting the attribute `default['sumologic']['use_json_path_dir']` appropriately. By default a single json file is used.
6. (Optional) Check if the path to the json file or the json folder is set correctly in the attribute `default['sumologic']['sumo_json_path']`. By default this is the path to the json file at `/etc/sumo.json` on Linux or `c:\sumo\sumo.json` on Windows.
7. Upload the cookbook to your Chef Server:

  ```
  knife cookbook upload sumologic-collector
  ```
8. Add the `sumologic-collector` receipe to your node run lists.  This step depends
on your node configuration, so specifics will not be described in this README.md.


Attributes
----------

<table>
  <tr>
    <td>['sumologic']['ephemeral']</td>
    <td>Boolean</td>
    <td>Sumo Logic Ephemeral Setting</td>
    <td>Required</td>
  </tr>
  <tr>
    <td>['sumologic']['installDir'] </td>
    <td>String</td>
    <td>Sumo Logic Install Directory</td>
    <td>Required</td>
  </tr>
  <tr>
    <td>['sumologic']['credentials']['bag_name']</td>
    <td>String</td>
    <td>Name of the data bag.</td>
    <td>Required</td>
  </tr>
  <tr>
    <td>['sumologic']['credentials']['item_name']</td>
    <td>String</td>
    <td>Name of the item within the data bag. </td>
    <td>Required</td>
  </tr>
  <tr>
    <td>['sumologic']['credentials']['secret_file']</td>
    <td>String</td>
    <td>Path to the local file containing the encryption secret key.</td>
    <td>Optional</td>
  </tr>
</table>

Resource/Provider
-----------------

sumologic_collector
---------

Provides actions for installing and managing a SumoLogic Collector

### Actions
`default` = `:install_and_configure`

#### :install
Installs an unconfigured and unregistered SumoLogic Collector. Use `:configure` to configure it later
```ruby
sumologic_collector 'C:\sumo' do
  action :install
end
```

#### :install_and_configure
Installs and configures a SumoLogic Collector. This is the default action
```ruby
sumologic_collector 'C:\sumo' do
  collector_name 'fileserver'
  sumo_access_id 'MYACCESSID'
  sumo_access_key 'MYACCESSKEY'
  proxy_host 'proxy.mydomain.com'
  proxy_port '8080'
end
```

#### :configure
Configures a pre-installed but unconfigured (and unregistered) SumoLogic Collector

*Note: The recommended flow to use this is to have the collector installed without
configuration or registration by using the `:install` action*
```ruby
sumologic_collector 'C:\sumo' do
  collector_name 'fileserver'
  sumo_access_id 'MYACCESSID'
  sumo_access_key 'MYACCESSKEY'
  proxy_host 'proxy.mydomain.com'
  proxy_port '8080'
  action :configure
end
```

#### :remove
Uninstalls a SumoLogic collector using the provided uninstaller

```ruby
sumologic_collector 'C:\sumo' do
  action :remove
end
```

#### :start
Starts the SumoLogic Collector

```ruby
sumologic_collector 'C:\sumo' do
  action :start
end
```
#### :stop
Stops the SumoLogic Collector

```ruby
sumologic_collector 'C:\sumo' do
  action :stop
end
```

#### :restart
Restarts the SumoLogic Collector

```ruby
sumologic_collector 'C:\sumo' do
  action :restart
end
```

### Attribute Parameters
See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Installed_Collectors/stu_user.properties)
for more information about these attributes.

| Attribute | Type | Description | Default | Required | Used Actions |
| --------- | ---- | ----------- | ------- | -------- | ------------ |
| `dir` | `String` | Directory where collector will be installed (`name` attribute) | none | `true` | all |
| `source` | `String` | URL to download collector installer from | none (uses the latest installer from SumoLogic) | `false` | `:install`, `:install_and_configure` |
| `collector_name` | `String` | Name of this Collector | `nil` | `false` | `:install_and_configure`, `:configure` |
| `collector_url` | `String` | URL used to register Collector for data collection API | `nil` | `false` | `:install_and_configure`, `:configure` |
| `sumo_token_and_url` | `String` | Encoded Setup Wizard token | `nil` | `false` | `:install_and_configure` |
| `sumo_access_id` | `String` | Access ID used when logging in with Access ID and Key | `nil` | `false` | `:install_and_configure`, `:configure` |
| `sumo_access_key` | `String` | Access Key used when logging in with Access ID and Key | `nil` | `false` | `:install_and_configure`, `:configure` |
| `proxy_host` | `String` | Sets proxy host when a proxy server is used | `nil` | `false` | `:install_and_configure`, `:configure` |
| `proxy_port` | `String`, `Fixnum` | Sets proxy port when a proxy server is used | `nil` | `false` | `:install_and_configure`, `:configure` |
| `proxy_user` | `String` | Sets proxy user when a proxy server is used with authentication | `nil` | `false` | `:install_and_configure`, `:configure` |
| `proxy_password` | `String` | Sets proxy password when a proxy server is used with authentication | `nil` | `false` | `:install_and_configure`, `:configure` |
| `proxy_ntlmdomain` | `String` | Sets proxy NTLM domain when a proxy server is used with NTLM authentication | `nil` | `false` | `:install_and_configure`, `:configure` |
| `sources` | `String` | Sets the JSON file describing sources to configure on registration | `nil` | `false` |  `:install_and_configure`, `:configure` |
| `sync_sources` | `String` | Sets the JSON file describing sources to configure on registration, which will be continuously monitored and synchronized with the Collector's configuration | `nil` | `false` | `:install_and_configure`, `:configure` |
| `ephemeral` | `Boolean` | When `true`, the Collector will be deleted after goes offline for a certain period of time | `false` | `false` | `:install_and_configure`, `:configure` |
| `clobber` | `Boolean` | When `true`, if there is any existing Collector with the same name, that Collector will be deleted | `false` | `false` | `:install_and_configure`, `:configure` |
| `disable_script_source` | `Boolean` | If your organization's internal policies restrict the use of scripts, you can disable the creation of script-based Script Sources. When this parameter is passed, this option is removed from the Sumo Logic Web Application, and Script Source cannot be configured | `false` | `false` | `:install_and_configure`, `:configure` |
| `wrapper_java_initmemory | `Integer` | Override the initial Java heap size | `nil` | `false` | `:configure |
| `wrapper_java_maxmemory | `Integer` | Override the maximum Java heap size | `nil` | `false` | `:configure |
| `runas_username` | `String` | Which user the daemon will run as | `nil` | `false` | `:install_and_configure`, `:install` |
| `winrunas_password` | `String` | On Windows, the password for the user the service will run as | `nil` | `false` | `:install_and_configure`, `:install` |
| `skip_registration` | `Boolean` | When `true` the collector will not register upon installation | `false` | `nil` | `:install_and_configure` |

sumologic_collector_installer
---------

*Note: `sumologic_collector_installer` has been deprecated, please use `sumologic_collector` with the `:install_and_configure` action (the default)*

Allows for additional customisation of the Sumo Logic Collector installer

### Actions
`default` = `:install`

- `:install` - installs the Sumo Logic Collector if it is not already installed

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Installed_Collectors/Step_4._Install_the_Collector/02_Quiet_Mode_Installation_Method)
for more information about these attributes.

- `dir` - Directory where the Collector will be installed
- `source` - URL where installer will be downloaded from
- `collector_name`
- `collector_url`
- `sumo_token_and_url`
- `sumo_access_id`
- `sumo_access_key`
- `proxy_host`
- `proxy_port`
- `proxy_user`
- `proxy_password`
- `proxy_ntlmdomain`
- `sources`
- `sync_sources`
- `ephemeral`
- `clobber`
- `runas_username`
- `winrunas_password`
- `skip_registration`

### Examples

```ruby
# Installs the Collector on Windows and skips registration
sumologic_collector_installer 'c:\sumo' do
  source 'https://collectors.sumologic.com/rest/download/win64'
  sumo_access_id node['SUMO_ACCESS_ID']
  sumo_access_key node['SUMO_ACCESS_KEY']
  skip_registration true
end
```

Collector Sources
---------

### Attribute Parameters

The following attributes are common to all of the sources listed below.

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

- `owner` - owner of the JSON Source configuration file
- `group` - group of the JSON Source configuration file
- `mode` - file mode of the JSON Source configuration file
- `source_name` - name of the source. **required**
- `source_json_directory` - directory where JSON Source configuration file will be stored. **required**
- `description`
- `category`
- `host_name`
- `time_zone`
- `automatic_date_parsing`
- `multiline_processing_enabled`
- `use_autoline_matching`
- `manual_prefix_regexp`
- `force_time_zone`
- `default_date_format`
- `filters`
- `alive`

sumo_source_docker
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `uri`
- `specified_containers`
- `all_containers`
- `cert_path`
- `source_type` - one of `:docker_stats`, `:docker_log`. **required**
- `collect_events`

### Examples

```ruby
sumo_source_docker 'docker_stats' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_stats
  uri 'https://127.0.0.1:2376'
  all_containers true
end

sumo_source_docker 'docker_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_log
  uri 'https://127.0.0.1:2376'
  all_containers true
end
```

sumo_source_local_file
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `path_expression` - **required**
- `blacklist`
- `encoding`

### Examples

```ruby
sumo_source_local_file 'local_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
end
```

sumo_source_local_windows_event_log
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `log_names` - **required**

### Examples

```ruby
sumo_source_local_windows_event_log 'local_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
end
```

sumo_source_remote_file
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `remote_hosts` - **required**
- `remote_port` - **required**
- `remote_user` - **required**
- `remote_password` - **required**
- `key_path` - **required**
- `key_password`
- `path_expression` - **required**
- `auth_method` - one of `key` or `password`.
- `blacklist`

### Examples

```ruby
sumo_source_remote_file 'remote_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  remote_hosts ['127.0.0.1']
  remote_port 22
  remote_user 'user'
  remote_password 'password'
  key_path ''
  path_expression '/tmp/example'
  auth_method 'password'
end
```

sumo_source_remote_windows_event_log
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `domain` - **required**
- `username` - **required**
- `password` - **required**
- `hosts` - **required**
- `log_names` - **required**

### Examples

```ruby
sumo_source_remote_windows_event_log 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names ['security', 'application']
end
```

sumo_source_script
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `commands` - **required**
- `file`
- `working_dir`
- `timeout`
- `script`
- `cron_expression`

### Examples

```ruby
sumo_source_script 'script' do
  source_json_directory node['sumologic']['sumo_json_path']
  commands ['/bin/bash']
  cron_expression '0 * * * *'
end
```

sumo_source_syslog
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `protocol`
- `port`

### Examples

```ruby
sumo_source_syslog 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end
```

sumo_source_graphite_metrics
---------

### Actions
`default` = `:create`

- `:create` - creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `protocol`
- `port`

### Examples

```ruby
sumo_source_graphite_metrics 'graphite' do
  source_json_directory node['sumologic']['sumo_json_path']
end
```

Contributing
------------
Please see CONTRIBUTING.md for guidelines


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com), Duc Ha (duc@sumologic.com)
