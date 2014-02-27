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

Pre-Requisites
--------------

You will need at least one [Access Key](http://help.sumologic.com/i19.69v2/Default.htm#Generating_Collector_Installation_API_Keys.htm)
before proceeding.

Installation
------------
    knife cookbook github install SumoLogic/sumo-collector-chef-cookbook

REQUIRED Setup
--------------
    knife data bag create sumo-config access-creds

```json
{
  "id": "access-creds",
  "accessID": "<access_id>",
  "accessKey": "<access_key>"
}
```

Usage
-----

Just include `sumo-collector` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sumo-collector]"
  ]
}
```

Contributing
------------
This cookbook is meant to help customers use chef to install Sumo Logic
collectors, so please feel to fork this repository, and make whatever changes
you need for your environment.


License and Authors
-------------------
Authors:
	Ben Newton (ben@sumologic.com)
