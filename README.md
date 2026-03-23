sumologic-collector Cookbook
============================
[![Cookbook Version](https://img.shields.io/cookbook/v/sumologic-collector.svg?style=flat)](https://supermarket.chef.io/cookbooks/sumologic-collector)
[![Build](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/actions/workflows/workflow-build.yml/badge.svg)](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/actions/workflows/workflow-build.yml)
[![PR Build](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/actions/workflows/pull_requests.yml/badge.svg)](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/actions/workflows/pull_requests.yml)

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
contain attributes `accessID` and `accessKey`. Note that attribute names are case sensitive.  If the cases mismatch, the values will not appear when chef-client runs. The default data bag/item is
`['sumo-creds']['api-creds']`. More flexible approach is to set `node.run_state['sumo_key_id']` and `node.run_state['sumo_key_secret']` to supply credentials from your wrapper cookbook level. Please note, storing sensitive data anywhere outside of `node.run_state` is not safe, because it's being uploaded to the Chef Server at the end of chef-client run. `node.run_state` [is not persistent and generally discarded at the end of chef-client run](https://docs.chef.io/recipes.html#node-run-state). But you still want to make sure that credentials originates from a secure place, such as your own encrypted data bag, Chef Vault or alternative approach that stores and communicates your secrets in an encrypted manner.
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

| Attribute | Type | Description | Required |
| --------- | ---- | ----------- | -------- |
| `['sumologic']['ephemeral']` | Boolean | Sumo Logic Ephemeral Setting | Required |
| `['sumologic']['installDir']` | String | Sumo Logic Install Directory | Required |
| `['sumologic']['credentials']['bag_name']` | String | Name of the data bag | Required |
| `['sumologic']['credentials']['item_name']` | String | Name of the item within the data bag | Required |
| `['sumologic']['credentials']['secret_file']` | String | Path to the local file containing the encryption secret key | Optional |

# Resource/Provider

## 1. sumologic_collector

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
| `collector_secure_files` | `Boolean` | Enable or disable enhanced file security | `nil` | `false` | `:install_and_configure`, `:install` |
| `host_name` | `String` | Hostname of this collector + default hostname of sources on it | `nil` | `false` | `:install_and_configure`, `:configure` |
| `description` | `String` | Description of this collector | `nil` | `false` | `:install_and_configure`, `:configure` |
| `category` | `String` | Default category for sources on this collector | `nil` | `false` | `:install_and_configure`, `:configure` |
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
| `disable_upgrade` | `Boolean` | If true, the collector rejects upgrade requests from Sumo. | `false` | `false` | `:install_and_configure`, `:configure` |
| `enable_script_source` | `Boolean` | Script Sources are disabled by default. You can enable them by setting this parameter to true. | `false` | `false` | `:install_and_configure`, `:configure` |
| `enable_action_source` | `Boolean` | Script Action Sources are disabled by default. You can enable them by setting this parameter to true. | `false` | `false` | `:install_and_configure`, `:configure` |
| `time_zone` | `String` | The default time zone for sources on this collector | `nil` | `false` | `:install_and_configure`, `:configure` |
| `target_cpu` | `Integer` | Target to which to limit the CPU usage of this collector | `nil` | `false` | `:install_and_configure`, `:configure` |
| `wrapper_java_initmemory` | `Integer` | Override the initial Java heap size | `nil` | `false` | `:configure` |
| `wrapper_java_maxmemory` | `Integer` | Override the maximum Java heap size | `nil` | `false` | `:configure` |
| `runas_username` | `String` | Which user the daemon will run as | `nil` | `false` | `:install_and_configure`, `:install` |
| `winrunas_password` | `String` | On Windows, the password for the user the service will run as | `nil` | `false` | `:install_and_configure`, `:install` |
| `skip_registration` | `Boolean` | When `true` the collector will not register upon installation | `false` | `nil` | `:install_and_configure` |
| `fields` | `Hash` | Sets the fields property in user.properties used by ingest budgets and other future features | `nil` | `false` | `:install_and_configure`, `:configure` |

## 2. sumologic_collector_installer

*Note: `sumologic_collector_installer` has been deprecated, please use `sumologic_collector` with the `:install_and_configure` action (the default)*

Allows for additional customisation of the Sumo Logic Collector installer

### Actions
`default` = `:install`

#### :install
Installs the Sumo Logic Collector if it is not already installed

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Installed_Collectors/Step_4._Install_the_Collector/02_Quiet_Mode_Installation_Method)
for more information about these attributes.

| Name | Description |
| ---- | ----------- |
| `dir` | Directory where the Collector will be installed |
| `source` | URL where installer will be downloaded from |
| `collector_name` | Name to assign to this Collector |
| `collector_url` | URL used to register Collector for data collection API |
| `sumo_token_and_url` | Encoded Setup Wizard token |
| `sumo_access_id` | Access ID used when logging in with Access ID and Key |
| `sumo_access_key` | Access Key used when logging in with Access ID and Key |
| `proxy_host` | Hostname of the proxy server |
| `proxy_port` | Port of the proxy server |
| `proxy_user` | Username for proxy authentication |
| `proxy_password` | Password for proxy authentication |
| `proxy_ntlmdomain` | Sets proxy NTLM domain when a proxy server is used with NTLM authentication |
| `sources` | Sets the JSON file describing sources to configure on registration |
| `sync_sources` | Path to JSON file describing sources to continuously sync with the Collector |
| `ephemeral` | When `true`, the Collector will be deleted after going offline for a certain period |
| `clobber` | When `true`, any existing Collector with the same name will be deleted |
| `runas_username` | User account the Collector daemon will run as |
| `winrunas_password` | Password for the Windows user account the Collector service will run as |
| `skip_registration` | When `true`, the Collector will not register upon installation |

### Examples

```ruby
# Installs the Collector on Windows and skips registration
sumologic_collector_installer 'c:\sumo' do
  source 'https://download-collector.sumologic.com/rest/download/win64'
  sumo_access_id node['SUMO_ACCESS_ID']
  sumo_access_key node['SUMO_ACCESS_KEY']
  skip_registration true
end
```

## 3. Collector Sources

### Attribute Parameters

The following attributes are common to all of the sources listed below.

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

| Name | Description |
| ---- | ----------- |
| `owner` | Owner of the JSON Source configuration file |
| `group` | Group of the JSON Source configuration file |
| `mode` | File mode of the JSON Source configuration file |
| `source_name` | Name of the source. **required** |
| `source_json_directory` | Directory where JSON Source configuration file will be stored. **required** |
| `description` | Human-readable description of this source |
| `category` | Source category to tag data collected by this source |
| `host_name` | Hostname to associate with log data collected by this source |
| `time_zone` | Time zone for this source |
| `automatic_date_parsing` | When `true`, automatically detects and parses date |
| `multiline_processing_enabled` | When `true`, enables multiline log message detection |
| `use_autoline_matching` | When `true`, uses automatic boundary detection for multiline messages |
| `manual_prefix_regexp` | Regular expression to use as a line boundary when `use_autoline_matching` is `false` |
| `force_time_zone` | When `true`, forces the source to use the specified `time_zone` |
| `default_date_format` | Default format to use when parsing timestamps |
| `filters` | List of processing rule filters to apply to data from this source |
| `alive` | When `false`, the source is disabled and stops collecting data |

## 4. sumo_source_docker

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `uri` | URI of the Docker daemon (e.g. `https://127.0.0.1:2376`) |
| `specified_containers` | List of specific container names or IDs to collect from |
| `all_containers` | When `true`, collects from all running containers |
| `cert_path` | Path to TLS certificates for connecting to the Docker daemon |
| `source_type` | Type of Docker source: one of `:docker_stats`, `:docker_log`. **required** |
| `collect_events` | When `true`, also collects Docker events |

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

## 5. sumo_source_local_file

### Actions

`default` = `:create`

#### :create
Creates a JSON Source configuration

#### :remove
Removes a previously configured JSON source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `path_expression` | Glob expression of file path(s) to collect. **required** |
| `blacklist` | Glob expression of file path(s) to exclude from collection |
| `encoding` | Character encoding of the log file (e.g. `UTF-8`, `ASCII`) |

### Examples

```ruby
sumo_source_local_file 'local_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
  fields {
    _siemforward: true,
    parser: '/MY_EXAMPLE_PARSER'
  }
end
```

## 6. sumo_source_local_windows_event_log

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `log_names` | List of Windows Event Log channels to collect from (e.g. `['security', 'application']`). **required** |
| `event_format` | Format for collected events: `:legacy` for legacy format or `:json` for JSON format. `:legacy` is default. |
| `event_message` | Used with JSON format. `:complete`, `:message` (recommended), or `:metadata` for metadata only. `:message` is default. |
| `allowlist` | Available in Collector version 19.351-4 and later. A comma-separated list of event IDs to include. Empty string by default. |
| `denylist` | Available in Collector version 19.351-4 and later. A comma-separated list of event IDs to exclude. Empty string by default. |

### Examples

```ruby
sumo_source_local_windows_event_log 'local_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
end
```

Use JSON log format instead of legacy format:

```ruby
sumo_source_local_windows_event_log 'local_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
  event_format :json
  event_message :message
  allowlist ""
  denylist ""
end
```

## 6. sumo_source_remote_file

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `remote_hosts` | List of remote host addresses to collect files from. **required** |
| `remote_port` | SSH port on the remote host. **required** |
| `remote_user` | Username to use for the remote SSH connection. **required** |
| `remote_password` | Password to use for the remote SSH connection. **required** |
| `key_path` | Path to the SSH private key file for key-based authentication. **required** |
| `key_password` | Passphrase for the SSH private key file |
| `path_expression` | Glob expression of file path(s) to collect on the remote host. **required** |
| `auth_method` | Authentication method: `key` for key-based or `password` for password-based. |
| `blacklist` | Glob expression of file path(s) to exclude from collection on the remote host ---- |

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

## 7. sumo_source_remote_windows_event_log

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic and [sumo_source_local_windows_event_log](#sumosourcelocalwindowseventlog) parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `domain` | Windows domain of the remote hosts. **required** |
| `username` | Username for authenticating with the remote Windows hosts. **required** |
| `password` | Password for authenticating with the remote Windows hosts. **required** |
| `hosts` | List of remote Windows host addresses to collect event logs from. **required** |
| `log_names` | List of Windows Event Log channels to collect from (e.g. `['security', 'application']`). **required** |

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

Use JSON log format instead of legacy format:

```ruby
sumo_source_remote_windows_event_log 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names ['security', 'application']
  event_format :json
  event_message :message
  allowlist ""
  denylist ""

end
```

## 8. sumo_source_script

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `commands` | List of command strings to execute the script (e.g. `['/bin/bash']`). **required** |
| `file` | |
| `working_dir` | Working directory in which the script will be executed |
| `timeout` | |
| `script` | |
| `cron_expression` | Cron expression controlling how often the script runs (e.g. `'0 * * * *'`) |

### Examples

```ruby
sumo_source_script 'script' do
  source_json_directory node['sumologic']['sumo_json_path']
  commands ['/bin/bash']
  cron_expression '0 * * * *'
end
```

## 9. sumo_source_syslog

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `protocol` | Network protocol to listen on: `TCP` or `UDP` |
| `port` | Port number to listen on for incoming syslog messages |

### Examples

```ruby
sumo_source_syslog 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end
```

## 10. sumo_source_graphite_metrics

### Actions
`default` = `:create`

#### :create
Creates a JSON Source configuration

### Attribute Parameters

See the [Sumo Logic documentation](https://help.sumologic.com/Send_Data/Sources/Use_JSON_to_Configure_Sources)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

| Name | Description |
| ---- | ----------- |
| `protocol` | Network protocol to listen on: `TCP` or `UDP` |
| `port` | Port number to listen on for incoming Graphite metrics |

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
