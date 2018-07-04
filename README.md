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
    .attach(top: Offset(20),
            left: Offset(10),
            bottom: Offset(0),
            right: Offset(10)
    .size(width: 24, height: 24)
```

The constraints will automatically be added to the correct views.

### As a generator for constraints
Sometimes you need to store the constraints that are generated. In this case you need to call the static methods on the `Constraint` class directly as follows:

    private var messageHeight: NSLayoutContraint?
	 ...
    let messageHeight = Constraint.height(50, for: message)
    view.addConstraint(messageHeight)
    self.messageHeight = messageHeight
    
In this case you will have to add the constraint manually to the view. It's the maximum amount of flexibility but a bit more work.

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
