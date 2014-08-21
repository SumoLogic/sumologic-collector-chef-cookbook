sumologic-collector Cookbook
============================
This cookbook installs the Sumo Logic collector. Linux installs use the shell script
installer and Windows uses the exe installer. Here are the steps it follows:

1. Sets up `sumo.conf` and `sumo.json`. By default the standard Linux logs are captured. On Windows the application and system event logs are captured.
2. Downloads latest installer
3. Runs installer
4. Starts collector and registers with the Sumo Logic service

The collector Requires outbound access to https://collectors.sumologic.com.
Edit `sumo.json` to add/edit/remove sources.  After installation you can
[test connectivity](https://service.sumologic.com/ui/help/Default.htm#Testing_Connectivity.htm).


Installation
------------
1. Create an [Access Key](http://help.sumologic.com/i19.69v2/Default.htm#Generating_Collector_Installation_API_Keys.htm)
2. Install the cookbook in your Chef repo (your knife version should be at least 11.10.4 and you should have the [knife github plugin](https://github.com/websterclay/knife-github-cookbooks) installed):

```knife cookbook github install SumoLogic/sumologic-collector-chef-cookbook```

3. Specify data bag and item with your access credentials.  The data item should
contain attributes `accessID` and `accessKey`.  Note that attribute names are case sensitive.  If the cases mismatch, the values will not appear when chef-client runs.  The default data bag/item is
`['sumo-creds']['api-creds']`

4. Upload the cookbook to your Chef Server:

```knife cookbook upload sumologic-collector```

5. Add the `sumologic-collector` receipe to your node run lists.  This step depends
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
	Ben Newton (ben@sumologic.com)
