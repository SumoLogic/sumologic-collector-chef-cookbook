sumologic-collector Cookbook
============================
This cookbook installs the Sumo Logic collector or updates an existing one if it was set to use [Local Configuration Mangement](https://service.sumologic.com/help/Default.htm#Using_Local_Configuration_File_Management.htm). Installation on Linux uses the shell script
installer and on Windows uses the exe installer. Here are the steps it follows:

1. Sets up `sumo.conf` and `sumo.json` (or the json folder). By default the standard Linux logs (system and security) are captured. On Windows the application and system event logs are captured.
2. Downloads latest installer
3. Runs installer
4. Starts collector and registers with the Sumo Logic service

For collector update, the existing collector must have been switched to use Local Configuration Mangement - see section [Make the switch](https://service.sumologic.com/help/Default.htm#Using_Local_Configuration_File_Management.htm) for more details. The steps the cookbook follows:

1. Verify that the collector folder exists.
2. (Optional) Recreate `sumo.conf` and `sumo.json` (or the json files under the json folder).
3. Restart the collector for the changes to take effect.   

The collector Requires outbound access to https://collectors.sumologic.com.
Edit `sumo.json` (or the json files under the json folder) to add/edit/remove sources.  After installation you can
[test connectivity](https://service.sumologic.com/ui/help/Default.htm#Testing_Connectivity.htm).


Note
------
Starting from 19.107, there are 2 major extensions to SumoLogic collectors:
* You can configure a collector's parameters from a set of json files under a common folder. Each of the json file will represent a source on that collector. Updates made to a json file will then be reflected on its corresponding source. Note that the format of this kind of file is **slightly different** from that of the traditional single json file (sumo.json) and they are **not** compatible. You also need to use the parameter `syncSources` instead of `sources` inside `sumo.conf`. See more details [here](https://service.sumologic.com/help/Default.htm#Using_sumo.conf.htm).
* You can change a collector's existing parameters through local configuration json file(s) continuously. Before this, using collector API was the only option. More information about this is [here](https://service.sumologic.com/help/Default.htm#Using_Local_Configuration_File_Management.htm)

Installation
------------
1. Create an [Access Key](http://help.sumologic.com/i19.69v2/Default.htm#Generating_Collector_Installation_API_Keys.htm)
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

sumologic_collector_installer
---------

Allows for additional customisation of the Sumo Logic Collector installer

### Actions
`default` = `:install`

- `:install` - installs the Sumo Logic Collector if it is not already installed

### Attribute Parameters

See the [Sumo Logic documentation](https://service.sumologic.com/help/Default.htm#Using_Quiet_Mode_to_Install_a_Collector.htm)
for more information about these attributes.

- `dir` - Directory where the Collector will be installed
- `source` - URL where installer will be downloaded from
- `collector_name`
- `collector_url`
- `sumo_email`
- `sumo_password`
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
for more information about these attributes.

The following attribute parameters are in addition to the generic parameters
listed above.

- `uri`
- `specified_containers`
- `all_containers`
- `cert_path`
- `source_type` - one of `:docker_stats`, `:docker_log`. **required**
- `collected_events`

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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

See the [Sumo Logic documentation](https://service.sumologic.com/help/#Using_JSON_to_configure_Sources.htm)
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

Contributing
------------
This cookbook is meant to help customers use Chef to install Sumo Logic
collectors, so please feel to fork this repository, and make whatever changes
you need for your environment.


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com), Duc Ha (duc@sumologic.com)
