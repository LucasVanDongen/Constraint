# Constraint
Constraint is a simple wrapper for iOS Auto Layout that has a very natural syntax

[![CI Status](https://img.shields.io/travis/lucasvandongen/Constraint.svg?style=flat)](https://travis-ci.org/lucasvandongen/Constraint)
[![Version](https://img.shields.io/cocoapods/v/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)
[![License](https://img.shields.io/cocoapods/l/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)
[![Platform](https://img.shields.io/cocoapods/p/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)

## Usage
### On the UIView
Usually you will use the `Constraint` library on the (descendant class of) `UIView` you want to constrain. Every call returns the `UIView` again so it's very easy to chain all of your layouts like this:

```        
icon
    .attach(top: 20,
            left: 10,
            bottom: 0,
            right: 10)
    .size(width: 24, height: 24)
```

Also there's the possibility to add various modifiers to offset constraints:

```
image.attach(top: 0.orMore, bottom: 12.defaultLowPriority)
// These are also chainable
label.attach(bottom: 0.orMore.priorityUpdated(to: UILayoutPriority(800))
```

### As a generator for constraints
Sometimes you need to store the constraints that are generated. In this case you need to call the static methods on the `Constraint` class directly as follows:

    private var messageHeight: NSLayoutContraint?
	 ...
    let messageHeight = Constraint.height(50, for: message)
    view.addConstraint(messageHeight)
    self.messageHeight = messageHeight
    
In this case you will have to add the constraint manually to the view. It's the maximum amount of flexibility but a bit more work.

## Known issues and TODO's
This is the `0.1` release of this library but it already has been used in a few projects internally and all of the major kinks have been worked out. The following issues exist:

* Not all class funcs on `Constraint` return `NSLayoutConstraint` or `[NSLayoutConstraint]` yet
* The Fluent API hasn't been used everywhere yet
* The API might undergo some name changes, for example probably `snap` will be deprecated in favor of a simple variant of `attach`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* Swift 4
* iOS

## Installation

Constraint is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Constraint'
```

## Author

lucasvandongen, lucas.van.dongen@gmail.com

## License

Constraint is available under the MIT license. See the LICENSE file for more info.
