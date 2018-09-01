# Constraint
Constraint is a simple wrapper for iOS Auto Layout that has a very natural syntax

[![CI Status](https://img.shields.io/travis/lucasvandongen/Constraint.svg?style=flat)](https://travis-ci.org/lucasvandongen/Constraint)
[![Version](https://img.shields.io/cocoapods/v/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)
[![License](https://img.shields.io/cocoapods/l/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)
[![Platform](https://img.shields.io/cocoapods/p/Constraint.svg?style=flat)](https://cocoapods.org/pods/Constraint)

## Usage
### On the UIView
Usually you will use the `Constraint` library on the (descendant class of) `UIView` you want to constrain. Every call returns the `UIView` again so it's very easy to chain all of your layouts like this:

```swift    
icon
    .attach(top: 20,
            left: 10,
            bottom: 0,
            right: 10)
    .size(width: 24, height: 24)
```

Also there's the possibility to add various modifiers to offset constraints:

```swift
image.attach(top: 0.orMore, bottom: 12.defaultLowPriority)
// These are also chainable
label.attach(bottom: 0.orMore.priorityUpdated(to: UILayoutPriority(800))
```

### As a generator for constraints
Sometimes you need to store the constraints that are generated. In this case you need to call the static methods on the `Constraint` class directly as follows:

```swift
private var messageHeight: NSLayoutContraint?
// ...
let messageHeight = Constraint.height(50, for: message)
view.addConstraint(messageHeight)
self.messageHeight = messageHeight
```
    
In this case you will have to add the constraint manually to the view. It's the maximum amount of flexibility but a bit more work.
## UIView API
These are all the publicly exposed extensions to `UIView`:
### `snap`
This method snaps the view inside of it's `parentView` with a desired offset. 

Usage:

```swift
view.snap() // Will default to 0
view.snap(offset: 12) // Will add 12 pixels of padding all around
```

### `attach`
This method is like `snap` but you can define every side separately or leave some sides out. It takes `Offsetable` as it's parameter which means you can either use a primitive like `Int` or `CGFloat` or you can send an `Offset` directly. 

Usage:

```swift
view.attach(top: 0, right: 12) // Does not apply the bottom and left constraints
view.attach(top: 0.orMore) // It's possible to use it with primitives and still modify the priority or relation type
view.attach(left: 12.orLess.defaultLowPriority) // These can also be chained
view.attach(bottom: Offset(0, .orMore, respectingLayoutGuide: true, priority: .defaultLow)) // Means the same as view.attach(bottom: 0.orMore.layoutGuideRespecting.defaultLowPriority)
```
`respectingLayoutGuide` / `layoutGuideRespecting` means it respects the layout guides, like in the root view of a `ViewController` where you expect it to respect the Safe Area sometimes. The default is to *not* respect the layout guides.

### `center`
Center lets you center the view inside another view, where it defaults to the `superview`. It's also possible to specify another view that needs to be part of the same view tree

Usage:

```Swift
view.center(axis: .both) // Centers the view on both the X and Y axis of it's superview
view.center(to: anotherView, axis: .x, adjusted: 10, priority: .defaultLow) // Wants to center it's X to anotherView, then adjusts it +10 pixels and applies a low priority to it
```
### `align`
Works pretty much the same as `center` actually and one of both might be depracated in the future in favor of the other. It aligns with another view which is not it's superview.

Usage
```Swift
view.align(axis: .x, to: anotherView, adjustment: 10) // Wants to center it's X to anotherView, then adjusts it +10 pixels
```

It also allows you to align a side instead of the middle:
```Swift
view.align(.left, 12, otherView) // Aligns it's left side to the left side of otherView + 12 pixels
```

If you want to align multiple sides (much like `align` does) you can do this too:
```Swift
view.align([.top, .left, .bottom], 0, to: otherView)
```

### `space`
Space the view to another view in any direction.

Usage
```
registerButton
    .space(20, .above, reconfirmButton)
    .space(8, .below, usernameLabel, .orMore, priority: .defaultLow)
```
### `width`, `height` and `size`
These functions are used to set the size of a UIView. You can set the width and height also related to the width or height of another view.

Usage:
```swift
otherView
    .size(width: 100, .orMore, height: 50)
view
    .width(relatedTo: otherView)
    .height(100)
```

### `ratio`
Ratio sets the ratio between the width and the height of view.

Usage:
```swift
view.ratio(of: 2) // Makes the width twice as much as the height
```

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
