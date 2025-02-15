## [2.5.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.4.0...v2.5.0) (2025-02-07)


### Features

* pass through resource variables for the task definition of redis ([#99](https://github.com/justtrackio/terraform-aws-kvstore/issues/99)) ([dc447ea](https://github.com/justtrackio/terraform-aws-kvstore/commit/dc447ea1f3d8ed760c4c0d39b92d5eac0683bd4f))

## [2.4.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.3.0...v2.4.0) (2025-02-05)


### Features

* pull redis from ecr by default ([#97](https://github.com/justtrackio/terraform-aws-kvstore/issues/97)) ([0573cb7](https://github.com/justtrackio/terraform-aws-kvstore/commit/0573cb756e8ddace5fa60f54e44e4a4e3f4f178e))

## [2.3.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.2.0...v2.3.0) (2025-01-30)


### Features

* update Terraform justtrackio/dynamodb-table/aws to v2.3.0 ([#68](https://github.com/justtrackio/terraform-aws-kvstore/issues/68)) ([4884329](https://github.com/justtrackio/terraform-aws-kvstore/commit/488432912c3cba2e441710d59790700a819f542c))

## [2.2.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.1.1...v2.2.0) (2024-04-15)


### Features

* add more flexibility to naming pattern ([#70](https://github.com/justtrackio/terraform-aws-kvstore/issues/70)) ([741074d](https://github.com/justtrackio/terraform-aws-kvstore/commit/741074d0e92a4c1493dc608b2d84c284a1bcf26f))

## [2.1.1](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.1.0...v2.1.1) (2023-11-15)


### Bug Fixes

* update dynamodb table version ([#56](https://github.com/justtrackio/terraform-aws-kvstore/issues/56)) ([3708717](https://github.com/justtrackio/terraform-aws-kvstore/commit/3708717994cb9e077801f89679b3d11a8777d24d))

## [2.1.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.0.4...v2.1.0) (2023-11-15)


### Features

* added scheduled scaling the backing ddb table ([#55](https://github.com/justtrackio/terraform-aws-kvstore/issues/55)) ([d9baa92](https://github.com/justtrackio/terraform-aws-kvstore/commit/d9baa921d3b3f779672a7aadf3e6aa440e17c18f))

## [2.0.4](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.0.3...v2.0.4) (2023-11-15)


### Bug Fixes

* update dynamodb-table module ([#53](https://github.com/justtrackio/terraform-aws-kvstore/issues/53)) ([c74529b](https://github.com/justtrackio/terraform-aws-kvstore/commit/c74529b2dfd90bf7a2f1b8e1b3ca2b56a993b6f0))

## [2.0.3](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.0.2...v2.0.3) (2023-11-13)


### Bug Fixes

* use justtrackio dynamodb-table module ([#51](https://github.com/justtrackio/terraform-aws-kvstore/issues/51)) ([d432471](https://github.com/justtrackio/terraform-aws-kvstore/commit/d43247171af5b45798592dbf3efc135568b38e79))

## [2.0.2](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.0.1...v2.0.2) (2023-11-10)


### Bug Fixes

* fixed output when redis not used ([#49](https://github.com/justtrackio/terraform-aws-kvstore/issues/49)) ([f3d0405](https://github.com/justtrackio/terraform-aws-kvstore/commit/f3d0405b09647a14f974a4b6efc1ed8b969b5770))

## [2.0.1](https://github.com/justtrackio/terraform-aws-kvstore/compare/v2.0.0...v2.0.1) (2023-09-28)


### Bug Fixes

* handle default for ddb autoscaling when on demand ([#44](https://github.com/justtrackio/terraform-aws-kvstore/issues/44)) ([505ac20](https://github.com/justtrackio/terraform-aws-kvstore/commit/505ac20f49b28ba590ead197de8937813ee4610a))

## [2.0.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.2.1...v2.0.0) (2023-09-27)


### ⚠ BREAKING CHANGES

* refactor module (#32)

### Features

* refactor module ([#32](https://github.com/justtrackio/terraform-aws-kvstore/issues/32)) ([33510dd](https://github.com/justtrackio/terraform-aws-kvstore/commit/33510ddcb646c80828cbece3899834ebb78b2742))

## [1.2.1](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.2.0...v1.2.1) (2023-05-15)


### Bug Fixes

* adjust_versions_variables_outputs ([#27](https://github.com/justtrackio/terraform-aws-kvstore/issues/27)) ([c99ef7b](https://github.com/justtrackio/terraform-aws-kvstore/commit/c99ef7b82e8fa24b6f4e1659983d6bdd89cca0b9))

# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.1.3...v1.2.0) (2023-01-20)


### Features

* add ability to set service discovery name for redis kvstore ([#15](https://github.com/justtrackio/terraform-aws-kvstore/issues/15)) ([18edb49](https://github.com/justtrackio/terraform-aws-kvstore/commit/18edb496fc1f8167d9b845ee8fdc953bcb5d8d04))

## [1.1.3](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.1.2...v1.1.3) (2023-01-17)


### Bug Fixes

* Table only case ([#14](https://github.com/justtrackio/terraform-aws-kvstore/issues/14)) ([4cba83a](https://github.com/justtrackio/terraform-aws-kvstore/commit/4cba83aee2aa66bb748753c1048b42ba8b76505e))

## [1.1.2](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.1.1...v1.1.2) (2023-01-17)


### Bug Fixes

* Attributes usages, label order var names and renames ([#13](https://github.com/justtrackio/terraform-aws-kvstore/issues/13)) ([172e8d8](https://github.com/justtrackio/terraform-aws-kvstore/commit/172e8d8165c228d39785291cc00b0465e237f3e8))

## [1.1.1](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.1.0...v1.1.1) (2023-01-04)


### Bug Fixes

* Adjust service discovery name ([#4](https://github.com/justtrackio/terraform-aws-kvstore/issues/4)) ([825b1b8](https://github.com/justtrackio/terraform-aws-kvstore/commit/825b1b8a1edb5e38067715023bf9a99eea6e24e3))

## [1.1.0](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.0.1...v1.1.0) (2022-12-19)


### Features

* Added ability to adjust label order for iam roles ([#3](https://github.com/justtrackio/terraform-aws-kvstore/issues/3)) ([d832c13](https://github.com/justtrackio/terraform-aws-kvstore/commit/d832c133105f8cbcd4a131fcde168d05638a547c))

## [1.0.1](https://github.com/justtrackio/terraform-aws-kvstore/compare/v1.0.0...v1.0.1) (2022-12-16)


### Bug Fixes

* Fixed resource naming ([#2](https://github.com/justtrackio/terraform-aws-kvstore/issues/2)) ([12f8145](https://github.com/justtrackio/terraform-aws-kvstore/commit/12f81456f66a5a09cb332cde8e68128908b5174b))

## 1.0.0 (2022-12-15)


### Features

* Added functionality ([#1](https://github.com/justtrackio/terraform-aws-kvstore/issues/1)) ([305c25a](https://github.com/justtrackio/terraform-aws-kvstore/commit/305c25a0f03143c86abb3775693c51a0b001d2c6))
