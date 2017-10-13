# CHANGELOG for sumologic-collector
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG (now) follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Added
TBD

### Changed
TBD

## [1.2.23] - 2017-10-12
### Added
- the ability to use `node['sumologic']['init_style']` to specify an override for an init subsystem while keeping the same defaults of delegating that to ohai detection.

## [1.2.22] - 2017-08-15
### Added
- allow setting max_memory to control memory consumption : PR#128 (@dannenberg)
- allow pinning version of chef-vault gem : PR#123 (@dhui)

### Changed
- make travisci tests do what users expect them to : PR#134 (@majormoses)
- updates for ubuntu 16.04, chef 13, fewer restart notifications, configure more java properties, misc kitchen platform updates : PR#122 (@RoboticCheese)
- misc CHANGELOG updates : PR#137 (@majormoses)


## [1.2.21] - 2017-06-12
### Changed
- appease CI, misc repo cleanup : Merged PR#125, 130 (@zl4bv, @majormoses)

## [1.2.20] - 2017-04-26
### Changed
- revert buggy changes: Undo PR#113 (@duchatran)

## [1.2.19] - 2017-03-29
### Changed
- prevent unnecessary collector restarts by only converge if changed  : Merge PR#113 (@dannenberg)

## [1.2.18] - 2017-02-07
### Added
- Adds the ability to define the source categories for the default files created in the json source
  folder.

## [1.2.17] - 2016-07-19
### Added
- Add service retries attempts and delays, fixed online help doc link : Merged PR#85,86 (@kquinsland, @meringu)

## [1.2.15] - 2016-05-26
### Fixed
- Fix windows service collector name [issue 61](https://github.com/SumoLogic/sumologic-collector-chef-cookbook/issues/61): Merged PR#77 (@wenwolf)
- Chef 11 compatibility improvements : Merged PR#76 (@elyobo)

## [1.2.14]
### Added
- Add `:disable`  and `:enable` actions to sumologic-collector, among other things: Merged PR#74 (@KierranM)

## [1.2.13]
### Fixed
- Use the proper net command to restart, start, and stop the collector on windows: Merged PR#72 (@KierranM)

## [1.2.12] - 2016-04-19
### Added
- Add a new `sumologic_collector` resource :  Merged PR#71  (@KierranM)

## [1.2.11] - 2016-03-21
### Fixed
- fixing typo with `forceTimeZone` : PR#67 (@zl4bv)

## [1.2.10] - 2016-03-04
### Added
- Added LWRP resources for source config files :  Merged PR#64 (@zl4bv)

## [1.2.9] - 2016-02-25
### Added
- Platform-family-specific install recipes
- Windows 2008r2 and 2012r2 support and testing

## [1.2.8] - 2016-02-19
### Added
- Debian 8.1 support and testing

## [1.2.7] - 2016-02-19
- Add action for debian 8.X
- Add support for ChefVault
- Ensure sumo-collector is running

## [1.2.6]
### Added
- Add support for restarting the collector on `Windows`

## [1.2.5] - 2015-10-08
### Added
- Add basic serverspec testing

## [1.2.0]
### Added
- Updated cookbook to support Access IDs and Keys
- Updated cookbook to support Local Collector Management and JSON directory option.

## [0.1.0] - 2015-09-02
- Initial release of sumologic-collector


- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.

[Unreleased]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.21...HEAD
[1.2.21]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.20...v1.2.21
[1.2.20]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.19...v1.2.20
[1.2.19]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.18...v1.2.19
[1.2.18]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.17...v1.2.18
[1.2.17]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.16...v1.2.17
[1.2.16]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.15...v1.2.16
[1.2.15]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.14...v1.2.15
[1.2.14]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.13...v1.2.14
[1.2.13]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.12...v1.2.13
[1.2.12]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.11...v1.2.12
[1.2.11]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.10...v1.2.11
[1.2.10]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.9...v1.2.10
[1.2.9]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.8...v1.2.9
[1.2.8]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.7...v1.2.8
[1.2.7]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.6...v1.2.7
[1.2.6]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.5...v1.2.6
[1.2.5]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.4...v1.2.5
[1.2.4]: https://github.com/SumoLogic/sumologic-collector-chef-cookbook/compare/v1.2.3...v1.2.4
