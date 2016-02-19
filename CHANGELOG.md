# CHANGELOG for sumologic-collector

All notable changes to this project will be documented in this file. This project adheres to [Semantic Versioning](http://semver.org/).

## 1.3.0
11/6/2015
* Add `sumologic_source` provider to create or delete a [SumoLogic "sources" JSON file.][sources] See `libraries` directory to examine the new providers, and see the accompanying tests in the `test` and `spec` directories. Look at the changes to .kitchen.yml for new test integration suites.
* Add chronologically ascending CHANGELOG.md.

## 1.2.6

* Add support for restarting the collector on `Windows`

## 1.2.5

* Add basic serverspec

## 1.2.00:

* Updated cookbook to support Access IDs and Keys
* Updated cookbook to support Local Collector Management and JSON directory option.

## 0.1.0:

* Initial release of sumologic-collector

[sources]: https://service.sumologic.com/help/Using_JSON_to_configure_Sources.htm
