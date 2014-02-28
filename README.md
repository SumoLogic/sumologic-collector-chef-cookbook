sumo-collector Cookbook
============================
This cookbook installs the Sumo Logic collector on Linux using the shell script
installer. Here are the steps it follows:

1. Sets up `sumo.conf` and `sumo.json` with standard Linux logs
2. Downloads latest installer
3. Runs installer
4. Starts collector and registers with the Sumo Logic service

The collector Requires outbound access to https://collectors.sumologic.com.
Edit `sumo.json` to add/edit/remove sources.  After installation you can
[test connectivity](https://service.sumologic.com/ui/help/Default.htm#Testing_Connectivity.htm).


Installation
------------
1. Create an [Access Key](http://help.sumologic.com/i19.69v2/Default.htm#Generating_Collector_Installation_API_Keys.htm)
2. Install the cookbook in your Chef repo:

```knife cookbook github install SumoLogic/sumo-collector-chef-cookbook```

3. Create a data bag with your access credentials:

```knife data bag create sumo-config access-creds```

```json
{
  "id": "access-creds",
  "accessID": "<access_id>",
  "accessKey": "<access_key>"
}
```

4. Upload the cookbook to your Chef Server:

    knife cookbook upload sumo-collector

5. Add the `sumo-collector` receipe to your node run lists.  This step depends
on your node configuration, so specifics will not be described in this README.md.

Contributing
------------
This cookbook is meant to help customers use Chef to install Sumo Logic
collectors, so please feel to fork this repository, and make whatever changes
you need for your environment.


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com)
