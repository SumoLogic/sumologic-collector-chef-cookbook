# CHANGELOG for sumologic-collector

This file is used to list changes made in each version of sumologic-collector.

## 1.2.21
* Merged PR#125, 130

## 1.2.20
* Undo PR#113

## 1.2.19
* Merge PR#113

## 1.2.18
* Adds the ability to define the source categories for the default files created in the json source
  folder.

## 1.2.17
* Merged PR#85,86 : Add service retries attempts and delays, fixed online help doc link.

## 1.2.15
* Merged PR#76,77: Fix [issue 61](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/issues/61) and Chef 11 incompatibility in metadata.rb

## 1.2.14
* Merged PR#74: Add :disable  and :enable action to sumologic-collector, among other things.

## 1.2.13
* Merged PR#72: Use the net command to restart, start, and stop the
  collector on windows

## 1.2.12
* Merged PR#71: Add a new sumologic_collector resource.

## 1.2.11
* Fixed issue 68 with PR#67

## 1.2.10
* Added LWRP resources per PR#64

## 1.2.9
* Platform-family-specific install recipes
* Windows 2008r2 and 2012r2 support and testing

## 1.2.8
* Debian 8.1 support and testing

## 1.2.7
02/19/2016
* Add action for debian 8.X
* Add support for ChefVault
* Ensure sumo-collector is running

## 1.2.6

* Add support for restarting the collector on `Windows`

## 1.2.5

* Add basic serverspec

## 1.2.00:

* Updated cookbook to support Access IDs and Keys
* Updated cookbook to support Local Collector Management and JSON directory option.

## 0.1.0:

* Initial release of sumologic-collector


- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
