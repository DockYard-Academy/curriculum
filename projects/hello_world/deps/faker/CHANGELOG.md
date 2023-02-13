# Change Log

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/).

Change log itself follows [Keep a CHANGELOG](http://keepachangelog.com) format.

## Unreleased

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## 0.17.0

### Added
- `Faker.Internet.StatusCode` [[@emmetreza](https://github.com/emmetreza)]
- CI workflow using GitHub Actions [[@anthonator](https://github.com/anthonator)]
- `Faker.Cat.PtBr` [[@f-francine](https://github.com/f-francine)]
- `Faker.Aws.PtBr.region_name/0` [[@f-francine](https://github.com/f-francine)]
- `Faker.Fruit.PtBr` [[@f-francine](https://github.com/f-francine)]
- `Faker.Commerce.PtBr` [[@f-francine](https://github.com/f-francine)]

### Changed
- `Faker.Vehicles` add makes and models that are multi-word, refactor existing fns [[jersearls](https://github.com/jersearls)]
- `Faker.Avatar` switch to `https` to prevent redirect [[igas](https://github.com/igas)]
- Updated build badge for GitHub Actions [[@anthonator](https://github.com/anthonator)]

### Deprecated

### Removed
- Travis CI for CI workflow [[@anthonator](https://github.com/anthonator)]

### Fixed

- `Faker.Team` `creature/0` and `name/0` documentation examples fixed [[@yuriploc](https://github.com/yuriploc)]
- Fix bidirectional formatting [[@MichalDolata](https://github.com/MichalDolata)]
- Extra split for Virgin Islands in the country sampler [[intercaetera](https://github.com/intercaetera)]
### Security

## 0.16.0

### Added

- `Faker.Markdown` [[techgaun](https://github.com/techgaun)]
- `Faker.Aws.En.rds_action/0` [[@vboivin](https://github.com/vboivin)]
- `Faker.Aws.En.ec2_action/0` [[@vboivin](https://github.com/vboivin)]
- `Faker.Aws.En.s3_action/0` [[@vboivin](https://github.com/vboivin)]
- `Faker.Aws.Fr.region_name/0` [[@vboivin](https://github.com/vboivin)
- `Faker.Aws.PtPt.region_name/0` [[@rubenandre](https://github.com/rubenandre)]
- `Faker.Phone.PtPt.number/0` [[@rubenandre](https://github.com/rubenandre)]
- `Faker.Phone.PtPt.landline_number/0` [[@rubenandre](https://github.com/rubenandre)]
- `Faker.Phone.PtPt.cell_number/0` [[@rubenandre](https://github.com/rubenandre)]
- `Faker.Aws.Fr.region_name/0` [[@vboivin](https://github.com/vboivin)]
- `Faker.String.naughty/0` [[@Cantido][https://github.com/Cantido]]
- `Faker.Airports.icao/0` [[@brunohkbx](https://github.com/brunohkbx)]
- `Faker.Airports.iata/0` [[@brunohkbx](https://github.com/brunohkbx)]
- `Faker.Airports.En.name/0` [[@brunohkbx](https://github.com/brunohkbx)]

### Changed

### Deprecated

### Removed

### Fixed

### Security

## 0.15.0

### Added

- `Faker.Person.Fr.name/0` [[@vboivin](https://github.com/vboivin)]
- `Faker.Gov.Us.ein/0` [[@artkay](https://github.com/artkay)]
- `Faker.Currency.code/0` and `Faker.Currency.symbol/0` [[@brunohkbx](https://github.com/brunohkbx)]
- `Faker.Address.PtBr` [[@hiagomeels](https://github.com/hiagomeels)]
- Elixir 1.11 support [[@igas](https://github.com/igas)]
- `Faker.Dog.PtBr`[[@caiaffa](https://github.com/caiaffa)]
- `Faker.Airports.PtBr`[[@caiaffa](https://github.com/caiaffa)]

### Changed

### Deprecated

### Removed

### Fixed

- `Faker.Date.date_of_birth/1` generating invalid date range on last day of the month [[@anthonator](https://github.com/anthonator)]

### Security

## 0.14.0

### Added

- Add missing `Faker.Name.Hy.suffix` doctests [[@vbrazo](https://github.com/vbrazo)]
- Add missing `Faker.Address.It` doctests [[@vbrazo](https://github.com/vbrazo)]
- Add CONTRIBUTING and update README [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Pokemon.It.location/0` [[@fusillicode](https://github.com/fusillicode)]
- `Faker.Pokemon.It.name/0` [[@fusillicode](https://github.com/fusillicode)]
- `Faker.Color.De.name/0` [[@hlhr](https://github.com/hlhr)]
- `Faker.Color.De.fancy_name/0` [[@hlhr](https://github.com/hlhr)]
- `Faker.Address.Ru.country/0` [[@igas](https://github.com/igas)]
- `Faker.Address.Ru.state/0` [[@igas](https://github.com/igas)]
- `Faker.Gov.It` [[@neslinesli93](https://github.com/neslinesli93)]
- `Faker.Vehicle.model/1` [[@daytonn](https://github.com/daytonn)]
- `Faker.Person`[[@anthonator](https://github.com/anthonator)]
- `Faker.Phone.PtBr`[[@netond](https://github.com/netond)]

### Changed
- Fix `Faker.Code.Iban.iban` and `Faker.Gov.It.fiscal_id` doctests [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Address.Es` [[@emig](https://github.com/emig)]
- Set minimum Elixir version to 1.6
- Set minimum OTP version to 19
- Fix `Faker.Vehicle.vin/0` to return valid vin [[@jimgerneer](https://github.com/jimgerneer)]
- Altered `Faker.Util.pick/1` now accepts optional blacklist [[@jimgerneer](https://github.com/jimgerneer)]

### Deprecated

- `Faker.Name` (in favor of `Faker.Person`) [[@anthonator](https://github.com/anthonator)]

### Removed

- Remove extra doctests in `Faker.Nato.format` [[@vbrazo](https://github.com/vbrazo)]
- GitLab CI [[@igas][]]
- Elixir 1.4 and 1.5 support

### Fixed
- `Faker.Util.upper_letter/0` documentation examples [[@michaelfich](https://github.com/michaelfich)]

### Security

## 0.13.0

### Added

- Elixir 1.9 support [[@igas](https://igas.me)]
- `Faker.Address.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Blockchain.Ethereum` [[@jeanparpaillon](https://github.com/jeanparpaillon)]
- `Faker.Cannabis.En` [[@nurugger07](https://github.com/nurugger07)]
- `Faker.Color.Fr` [[@popo63301](https://github.com/popo63301)]
- `Faker.Color.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Commerce.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Company.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Finance.Stock` [[@thomascharbonnel](https://github.com/thomascharbonnel)]
- `Faker.Food.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Food.PtBr` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Industry.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Internet.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Name.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Phone.Hy` [[@hovikman](https://github.com/hovikman)]
- `Faker.Pokemon.De` [[@mrmstn](https://github.com/mrmstn)]
- `Faker.Vehicle` [[@daytonn](https://github.com/daytonn)]

### Changed

- `Faker.Pokemon.En.name/0` added more Pokemon names [[@hdahlheim](https://github.com/hdahlheim)]
- Simplified `Faker.UUID.v4/0` [[@whatyouhide](https://github.com/whatyouhide)]
- Replace UTF8 1FBF with ASCII single quote in the Italian locale [[@pmontrasio](https://github.com/pmontrasio)]
- Bump `credo` from **1.0.2** to **1.1.4**
- Bump `earmark` from **1.3.1** to **1.4.1**
- Bump `ex_doc` from **0.19.3** to **0.21.2**
- Bump `makeup` from **0.8.0** to **1.0.0**
- Bump `makeup_elixir` from **0.13.0** to **0.14.0**
- Bump `nimble_parsec` from **0.5.0** to **0.5.1**

### Fixed

- `Faker.DateTime` indexing in documentation [[@jalcine](https://github.com/jalcine)]
- `Faker.File` typespecs [[@frm](https://github.com/frm)]
- industry tests [[@hovikman](https://github.com/hovikman)]
- credo warnings on CI [[@igas](https://igas.me)]

## 0.12.0

### Added

- New maintainer [Vitor Oliveira (@vbrazo)](https://github.com/vbrazo)
- New maintainer [Anthony Smith (@anthonator)](https://github.com/anthonator)
- `Faker.Blockchain` namespace [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Address.It`, `Faker.Color.It`, `Faker.Internet.It` and `Faker.Name.It` [[@pmontrasio](https://github.com/pmontrasio)]

### Changed

- Bump `ex_doc` from **0.19.1** to **0.19.3**
- Bump `earmark` from **1.3.0** to **1.3.1**
- Bump `credo` from **1.0.1** to **1.0.2**

### Deprecated

- `Faker.Bitcoin` in favour of `Faker.Blockchain.Bitcoin` [[@igas](https://igas.me)]

### Fixed

- Typo in Faker.Pizza [[@gmcintire](https://github.com/gmcintire)]
- Elixir 1.8.0 `DateTime` deprecation [[@vnegrisolo](https://github.com/vnegrisolo)]
- Quotes removal in `Faker.Internet` functions [[@jc00ke](https://github.com/jc00ke)] & [[@igas](https://igas.me)]
- Documentation issues [[@hovikman](https://github.com/hovikman)]

### Security

## 0.11.2

### Fixed

- `Faker.Util.pick/1` performance regression [[@aptinio](https://github.com/aptinio)] & [[@elbow-jason](https://github.com/elbow-jason)]

## 0.11.1

### Changed

- all localized functions now use Faker.localize/1 [[@igas](https://igas.me)]

### Removed

- Elixir 1.5 from CI [[@igas](https://igas.me)]
- dialyzer warning suppressions [[@igas](https://igas.me)]

### Fixed

- `Faker.Util.pick/1` work with `Enum` type now [[@igas](https://igas.me)]
- `Faker.localize/1` is calling `Kernel.function_exported?/3` with the wrong parameter [[@indocomsoft](https://github.com/indocomsoft)]
- `Faker.StarWars.En` Changed Palpatine to Sheev Palpatine, and fixed typo for Beru Lars [[@theabrad](https://github.com/theabrad)]

## 0.11.0

### Added

- Tests covered by actual values not just checking that result is a binary [[@igas](https://igas.me)]
- `Faker.Address.Es` and `Faker.Address.En` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Beer.brand/0` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Food.sushi/0` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Team.PtBr` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Name.PtBr` and `Faker.Name.Es` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.UUID.v4/0` [[@anthonator](https://github.com/anthonator)]
- `Faker.Food` to generate Food data [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Color.En`, `Faker.Color.Es` and `Faker.Color.PtBr` [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Internet` added Spanish and Brazilian Portuguese translations [[@vbrazo](https://github.com/vbrazo)]
- `Faker.Address.geohash/0` [[@anthonator](https://github.com/anthonator)] and [[@feyl](https://github.com/feyl)]
- `Faker.Util.sample_uniq/2` [[@fenollp](https://github.com/fenollp)]

### Changed

- Remove `'` and `"` from generated names in `Faker::Internet` [[@vbrazo](https://github.com/vbrazo)]
- Codebase been reformatted with elixir formatter [[@vbrazo](https://github.com/vbrazo)] and [[@igas](https://igas.me)]
- Documentation moved to hexdocs.pm [[@MarcusSky](https://github.com/MarcusSky)], [[@vbrazo](https://github.com/vbrazo)], and [[@igas](https://igas.me)]
- Updated dependencies [[@igas](https://igas.me)]

### Fixed

- `Faker.App.semver/0` is not generating invalid versions anymore fixed by [[@igas](https://igas.me)] found by [[@ConnorRigby](https://github.com/ConnorRigby)]
- `Faker.Lorem` is not redefining documentation in multiple functions anymore fixed and found by [[@pfac](https://github.com/pfac)]

## 0.10.0

### Added

- New maintainer [Toby Hinloopen (@tobyhinloopen)](https://github.com/tobyhinloopen)
- Gitter chat [room](https://gitter.im/igas/faker) [[@igas](https://igas.me)]
- `Faker.Gov.Us.ssn/0` added to generate US Social Security numbers [[@sotojuan](https://github.com/sotojuan)]
- `Faker.StarWars` added to generate `character/0`, `planet/0` and `quote/0` from StarWars universe [[@samcdavid](https://github.com/samcdavid)]
- `Faker.Cat` added to generate `name/0`, `breed/0` and `registry/0` of cats [[@orieken](https://github.com/orieken)]
- Customizable random functions [[@igas](https://igas.me)]
- `Faker.Industry` [[@cdesch](https://github.com/cdesch)]
- Missing colors to `Faker.Color.En` [[@cdesch](https://github.com/cdesch)]
- Elixir 1.6 support [[@igas](https://igas.me)]

### Changed

- Updated dependencies [[@igas](https://igas.me)]

### Removed

- Elixir 1.3 support [[@igas](https://igas.me)]

### Fixed

- `Faker.Date.date_of_birth/0` and `Faker.Date.date_of_birth/1` returning wrong result [[@stfnsr](https://github.com/stfnsr)]
- Usage.md reorganisation [[@orieken](https://github.com/orieken)]
- Documentation for `Faker.Beer` [[@bcat-eu](https://github.com/bcat-eu)]
- Fix Pokemon name - Mr. Mime :) [[@leveloid](https://github.com/leveloid)]
- Gov.Us deprecations [[@halfdan](https://github.com/halfdan)]

## 0.9.0

### Added

- `Faker.Pizza` [[@lauraannwilliams](https://github.com/lauraannwilliams)]
- Credo on CI [[@igas](https://igas.me)]
- Dialyxir on CI [[@igas](https://igas.me)]
- `Faker.String.base64/0` and `Faker.String.base64/1` [[@yordis](https://github.com/yordis)]

### Removed

- Elixir < 1.3 support [[@igas](https://igas.me)]

### Fixed

- Credo issues [[@lrosa007](https://github.com/lrosa007)]

## 0.8.0

### Added

- `Faker.Internet.UserAgent` [[@devshane](https://github.com/devshane)]
- `Faker.Superhero` [[@orieken](https://github.com/orieken)]
- `Faker.Code.iban` [[@tobyhinloopen](https://github.com/tobyhinloopen)]
- `Faker.Beer` [[@orieken](https://github.com/orieken)]
- `Faker.Date` [[@tobyhinloopen](https://github.com/tobyhinloopen)]
- `Faker.Date.between` [[@anthonator](https://github.com/anthonator)]
- `Faker.DateTime` [[@anthonator](https://github.com/anthonator)]
- `Faker.NaiveDateTime` [[@anthonator](https://github.com/anthonator)]
- `Faker.Nato` [[@petehamilton](https://github.com/petehamilton)]
- `Faker.Pokemon` [[@orieken](https://github.com/orieken)]
- `Faker.App.semver` [[@wojtekmach](https://github.com/wojtekmach)]
- `Faker.Internet.slug` [[@anthonator](https://github.com/anthonator)]
- credo [[@igas](https://igas.me)]

### Changed

- Underlying data structure changed to maps to improve performance [[@igas](https://igas.me)]
- Improved `Faker.Beer` usage [[@tbash](https://github.com/tbash)]

### Removed

- Usage docs duplication [[@piton4eg](https://github.com/piton4eg)]

### Fixed

- Elixir 1.4 deprecation warnings [[@igas](https://igas.me)]

## 0.7.0

- Upgrade to latest versions [[@belaustegui](https://github.com/belaustegui)]
- Documentation improvements [[@GesJeremie](https://github.com/GesJeremie)]
- `Faker.Color.En.name/0` & `Faker.Color.En.fancy_name/0` [[@efexen](https://github.com/efexen)]
- `Faker.Phone.EnGb.cell_number/0` [[@igas](https://igas.me)]
- `Faker.Phone.EnGb.landline_number/0` [[@johnhamelink](https://github.com/johnhamelink)]
- `Faker.Phone.EnGb.mobile_number/0` [[@igas](https://igas.me)]
- `Faker.Phone.EnGb.number/0` [[@igas](https://igas.me)]
- `Faker.Phone.EnUs` [[@devshane](https://github.com/devshane)]

## 0.6.0

- Most of functions covered by specs and docs now
- Removed JSON programming and poison dependency [[@saulecabrera](https://github.com/saulecabrera)] and [[@vforvova](https://github.com/vforvova)]
- Add Faker.Shakespeare [[@adam-wanninger](https://github.com/adam-wanninger)]
- Fix SSL issues in `Internet.image_url/0` [[@zmoshansky](https://github.com/zmoshansky)]
- Improve tests [[@lowks](https://github.com/lowks)]
- Elixir 1.1 support
- Add `Faker.App` with `author/0`, `name/0` and `version/0`
- Add `Faker.Address.country_code/0`
- Add `Faker.Bitcoin` with `address/0` and `address/1`
- Add `Faker.Color` with `rgb_hex/0` and `rgb_decimal/0`

## 0.5.1

- Add erlang 18 support
- Add issn check digit

## 0.5.0

- Add `Faker.start/0` and `Faker.start/1`

## 0.4.1

- Add `Faker.Internet.url/0` and `Faker.Internet.image_url/0` functions

## 0.4.0

- Elixir 1.0.0
- ISBN check digit algorithm [[@vforvova](https://github.com/vforvova)]
- Move from JSEX to Poison

## 0.3.2

- Fixed function heads [[@jarednorman](https://github.com/jarednorman)]

## 0.3.1

- Elixir 0.14.2

## 0.3.0

- Elixir v0.14 support
- Add Travis CI
- Remove `Faker.Config`
- Remove `Faker.Supervisor`
- Change dependency to hex packages
- Added `Faker.Internet`
  - `domain_name/0`
  - `domain_suffix/0`
  - `domain_word/0`
  - `email/0`
  - `free_email/0`
  - `free_email_service/0`
  - `ip_v4_address/0`
  - `ip_v6_address/0`
  - `mac_address/0`
  - `safe_email/0`
  - `user_name/0`
- Added `Faker.Company`
  - `bs/0`
  - `bullshit/0`
  - `bullshit_prefix/0`
  - `bullshit_suffix/0`
  - `buzzword/0`
  - `buzzword_prefix/0`
  - `buzzword_suffix/0`
  - `catch_phrase/0`
  - `name/0`
  - `suffix/0`

## 0.2.0

- Added `Faker.Team`
  - `name/0`
  - `creature/0`
