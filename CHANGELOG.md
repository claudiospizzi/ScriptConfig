# Changelog

All notable changes to this project will be documented in this file.

The format is mainly based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 3.2.0 - 2026-01-14

* Added: Support for auto-detect the config file format based the content (Get-ScriptConfig)
* Fixed: Fix INI loading for arrays and hash tables in PowerShell 7 (ConvertFrom-ScriptConfigIni)

## 3.1.0 - 2019-09-16

* Added: Auto-detect the config file if -Path was not specified

## 3.0.0 - 2019-02-18

* Changed: Get the default config path from the PS call stack
* Changed: The default configuration file type is now JSON (BREAKING CHANGE)

## 2.0.0 - 2016-12-12

* Changed: Convert module to new deployment model
* Changed: Rework code against high quality module guidelines by Microsoft
* Changed: Remove positional parameters (BREAKING CHANGE)

## 1.0.3 - 2016-02-09

* Added: Formats and types resources

## 1.0.2 - 2016-02-03

* Fixed: Default path issue for Get-ScriptConfig

## 1.0.1 - 2016-01-29

* Updated: File encoding to UTF8 w/o BOM
* Updated: Demo and help
* Added: Enhance parameters for Get-ScriptConfig function

## 1.0.0 - 2016-01-21

* Added: Initial public release
