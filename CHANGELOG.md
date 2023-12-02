# Changelog

## [next] - unreleased

- [#90](https://github.com/simonneutert/papierkram_api_client/pull/90) crud ops for time_entries. [@simonneutert](https://github.com/simonneutert)

## [0.3.1] - 2023-10-05

### Updated

Several dependencies were updated to their latest versions.

## [0.3.0] - 2023-09-10

### Changes (BREAKING! ⚠️)

- [#63](https://github.com/simonneutert/papierkram_api_client/pull/63) Cleaner abstraction for the API client to return a certain item by id. [@simonneutert](https://github.com/simonneutert)

### Added

- [#61](https://github.com/simonneutert/papierkram_api_client/pull/61) Adds ENV to make Minitest pass ([follow Alice](https://github.com/ordinaryzelig/minispec-metadata/pull/18)). [@simonneutert](https://github.com/simonneutert)
- [#55](https://github.com/simonneutert/papierkram_api_client/pull/55) Adds missing chapter for Transactions. [@simonneutert](https://github.com/simonneutert)

## [0.2.4] - 2023-06-30

### Fixed

- [#48](https://github.com/simonneutert/papierkram_api_client/pull/48) Arguments weren't truly optional when possible. [@simonneutert](https://github.com/simonneutert)

[0.2.3] - 2023-06-29

### Added

- [#47](https://github.com/simonneutert/papierkram_api_client/pull/47) Adds CRUD endpoint support for income propositions. [@simonneutert](https://github.com/simonneutert)
- [#46](https://github.com/simonneutert/papierkram_api_client/pull/46) Adds CRUD endpoint support for projects. [@simonneutert](https://github.com/simonneutert)
- [#45](https://github.com/simonneutert/papierkram_api_client/pull/45) Adds CRUD endpoint support for contact companies persons. [@simonneutert](https://github.com/simonneutert)

## [0.2.2] - 2023-06-28

### Fixed

- [#29](https://github.com/simonneutert/papierkram_api_client/pull/29) Fixing namespaces in tests. [@simonneutert](https://github.com/simonneutert)

### Changed

- [#24](https://github.com/simonneutert/papierkram_api_client/pull/24) Changes logo to a red version one, to match the NodeJS sister project. [@simonneutert](https://github.com/simonneutert), [@rabocalypse](https://github.com/rabocalypse)

### Added

- [#44](https://github.com/simonneutert/papierkram_api_client/pull/44) Adds CRUD endpoint support for contact companies. [@simonneutert](https://github.com/simonneutert)
- [#22](https://github.com/simonneutert/papierkram_api_client/pull/22) Factors out VcrSanitizer and adds some more Rubocop goodness. [@simonneutert](https://github.com/simonneutert)
- [#21](https://github.com/simonneutert/papierkram_api_client/pull/21) Adds more auto-sanitizing in VCR. [@simonneutert](https://github.com/simonneutert)

## [0.2.1] - 2023-04-21

### Added

- [#20](https://github.com/simonneutert/papierkram_api_client/pull/20) Adds Banking::Transactions as endpoint with tests. [@simonneutert](https://github.com/simonneutert)

## [0.2.0] - 2023-04-18

Das Namespacing hat sich geändert. Die Klasse `PapierkramApiClient` ist jetzt `PapierkramApi::Client`.

Bitte schaue für Details in die upgedatete Dokumentation in [README.md](README.md) und passe gegebenenfalls deinen Code an.

### Changed

- [#19](https://github.com/simonneutert/papierkram_api_client/pull/19) Bump rubocop from 1.50.1 to 1.50.2. [@simonneutert](https://github.com/simonneutert)
- [#18](https://github.com/simonneutert/papierkram_api_client/pull/18) Stub basic business intelligence module. [@simonneutert](https://github.com/simonneutert)

## [0.1.3] - 2023-04-15

Solltest du diesen Client mithilfe von Umgebungsvariablen einrichten, musst du deinen Code aktualisieren, um die neuen Variablen zu verwenden. Siehe `.env.sample` für die aktualisierten Variablen.

- `PAPIERKRAM_SUBDOMAIN` ist jetzt `PAPIERKRAM_API_SUBDOMAIN`

### Changed

[#17](https://github.com/simonneutert/papierkram_api_client/pull/17) tests expense vouchers endpoint and parameters. [@simonneutert](https://github.com/simonneutert)

## [0.1.2] - 2023-04-13

### Fixed

- [#10](https://github.com/simonneutert/papierkram_api_client/pull/10) Rubocop nun Teil der CI Pipeline und Hinweise auf Parameter für die API Calls in der Dokumentation. [@simonneutert](https://github.com/simonneutert)

### Changed

- [#11](https://github.com/simonneutert/papierkram_api_client/pull/11) Create .github/dependabot.yml. [@simonneutert](https://github.com/simonneutert)
- [#9](https://github.com/simonneutert/papierkram_api_client/pull/9) Hinweis VCR/Testing in Readme. [@simonneutert](https://github.com/simonneutert)
- [#8](https://github.com/simonneutert/papierkram_api_client/pull/8) Ergänzt Schnellstart Kapitel in Readme. [@simonneutert](https://github.com/simonneutert)
- [#7](https://github.com/simonneutert/papierkram_api_client/pull/7) Logo Version 3. [@rabocalypse](https://github.com/rabocalypse)
- [#5](https://github.com/simonneutert/papierkram_api_client/pull/5) Logo geändert. [@rabocalypse](https://github.com/rabocalypse)
- [#4](https://github.com/simonneutert/papierkram_api_client/pull/4) Verbesserung der Docs für PDF endpoints. [@simonneutert](https://github.com/simonneutert)
- [#3](https://github.com/simonneutert/papierkram_api_client/pull/3) Readme angepasst. [@simonneutert](https://github.com/simonneutert)

## [0.1.1] - 2023-04-12

### Changed

- [#2](https://github.com/simonneutert/papierkram_api_client/pull/2) Changelog und Readme angepasst. [@simonneutert](https://github.com/simonneutert)
- [#1](https://github.com/simonneutert/papierkram_api_client/pull/1) Logo hinzugefügt, in Readme eingebaut. [@rabocalypse](https://github.com/rabocalypse)

## [0.1.0] - 2023-04-12

- Initial release
