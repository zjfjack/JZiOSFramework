# JZiOSFramework

[![Build Status](https://travis-ci.org/zjfjack/JZiOSFramework.svg?branch=master)](https://travis-ci.org/zjfjack/JZiOSFramework)
[![CocoaPods](https://img.shields.io/cocoapods/v/JZiOSFramework.svg)](https://cocoapods.org/pods/JZiOSFramework)
[![Platform](https://img.shields.io/cocoapods/p/JZiOSFramework.svg?style=flat)](https://github.com/zjfjack/JZiOSFramework)
[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![license MIT](https://img.shields.io/cocoapods/l/JZiOSFramework.svg)](http://opensource.org/licenses/MIT)

Basic framework for iOS Swift, such as extensions, base classes and utils

## Features

### Useful components

- CopyableLabel: A Label subclassed from UILabel allowing long press to copy
- JZAlertController: Custom Alert Controller by providing custom view and actions

### Service

- ConfigurationManager: Configuration environment setup
- ApiManager: Wrapper for Alamofire and ObectMapper (Post, Download and Upload)
- FileService: Create path, get mime type and remove files

### Utils

- ToastUtil: Android-like middle Toast and Top&Bottom toast(Support tap to dismiss & iPhone X)
- PhotoUtil: Fully error handling for getting photos from camera and photoLibrary
- LocationUtil: Open Apple maps and GoogeMaps with location string
- DeviceUtil: Basic device information & Biometric Authentication setup
- ViewControllerUtil: HUD progess view implemented

### Extensions

- NSLayoutConstraintExtensions: Programmtically add constraints for views (Visual Format Language)
- UIViewExtensions: Programmtically add constraints for views (Anchor)
- StringExtensions: Localization helper

## Requirements

- iOS 9.0+
- Xcode 9.3+
- Swift 4.1+

## Installation

### Cocoapods
JZiOSFramework can be added to your project by adding the following line to your `Podfile`:

```ruby
pod 'JZiOSFramework', '~> 1.0'
```
