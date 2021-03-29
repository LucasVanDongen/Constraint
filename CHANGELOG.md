# Constraint Change Log

All notable changes to this project will be documented in this file.

## 0.9.1
This is an inbetween version where we adapted the library to be better for internationalized projects. In a future release left / right constraints will be available again, but only when the user understands it's attaching or spacing non-naturally. The goal is to get the API in such a shape it never needs to change anymore until shipping the final version 1.0.

- Swapped every specific left constraint for leading and right for trailing
- .leftOf has been renamed to .leading and .rightOf to .trailing

## 0.9.3
Bugfix

- Fixed nasty bug where leading and trailing would be swapped
- Removed unused parameter from a function that would confuse somebody using it

## 0.9.4
- Returning `Self` instead of `UIView` to retain class
- Created `addedAsSubview` function that adds a view fluently as a subview
- Created an extension for `[UIView]` with the following functions:
	- `addedAsSubviews` to add a an array of views fluently
	- `space` to space an array of views with a certain distance in a certain direction
	- `attach` to attach an array of views inside their parentviews
- Bufixes:
	- Made compiler understand not typing a distance when using `space` means 0
	- `attach` now passes `respectingLayoutGuides` properly
	- `width` can have a priority now

## 0.9.5
- Update to Swift 5
- Fixed bug where the relation had to be reversed for `.below` and `.trailing` spacing
- Added functions to size arrays of elements like `width`, `height` and `ratio`
- `center` now can have a relation (less/more)
- `ratio` can have a priority now
- Fixed a bug in bottom constraints with a relation
- Added `addedAsArrangedSubview` to chain functions on views you want to add to `UIStackView`s
- When a `.zero`  `CGSize` is used for determining a ratio your application does not longer crash

## 0.9.6
- Added SPM (Swift Package Manager) support

Planned
-------
- Adding spaceUnnatural() for being able to space .leftOf and .rightOf again
- Adding attachUnnatural() to allow to attach to .left and .right again
- Easier syntax for capturing multiple constraints, deprecation of direct access to `Constraint` functions
