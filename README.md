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
```knife cookbook github install SumoLogic/sumologic-collector-chef-cookbook``` 
3. Specify data bag and item with your access credentials.  The data item should
contain attributes `accessID` and `accessKey`.  Note that attribute names are case sensitive.  If the cases mismatch, the values will not appear when chef-client runs.  The default data bag/item is
`['sumo-creds']['api-creds']`
4. (Optional) Decide if you want to use the Local Configuration Management feature by setting the attribute `default['sumologic']['local_management']` properly. By default this feature is on, to leverage the power of Chef. 
5. (Optional) Select the json configuration option (i.e. through a single file or a folder) by setting the attribute `default['sumologic']['use_json_path_dir']` appropriately. By default a single json file is used.
6. (Optional) Check if the path to the json file or the json folder is set correctly in the attribute `default['sumologic']['sumo_json_path']`. By default this is the path to the json file at `/etc/sumo.json` on Linux or `c:\sumo\sumo.json` on Windows. 
7. Upload the cookbook to your Chef Server:
```knife cookbook upload sumologic-collector```
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

Contributing
------------
This cookbook is meant to help customers use Chef to install Sumo Logic
collectors, so please feel to fork this repository, and make whatever changes
you need for your environment.


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com), Duc Ha (duc@sumologic.com)
