# ExceptionCatcher
Catch [Objective-C exceptions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Exceptions/Tasks/HandlingExceptions.html) in Swift! 🪤

## Details

There are many Cocoa APIs that can throw exceptions that cannot be caught in Swift (for instance `NSKeyedUnarchiver`, `NSTask`,  `NSObject#value(forKey:)`). This package wraps an Objective-C exception handler to make it possible to catch such exceptions.

*The ability to catch exceptions should really be built into Swift. If you agree, duplicate [this](https://github.com/feedback-assistant/reports/issues/74) Feedback Assistant report.*

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/ExceptionCatcher", exact: .init(2, 0, 8))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)

## Usage

```swift
import ExceptionCatcher

final class Foo: NSObject {}

do {
    let value = try ExceptionCatcher.rethrow {
        Foo().value(forKey: "nope")
    }
    print("Value: ", value)
} catch {
    print("Error: ", error.localizedDescription)
    // Error: [<ExceptionCatcher.Foo 0x6000034c0030> valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope.

    debugPrint(error)
    /*
    Error Domain=NSUnknownKeyException Code=0 "[valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope." UserInfo={CallStackSymbols=(
    0   CoreFoundation                      0x00007fff361798ab __exceptionPreprocess + 250
    1   libobjc.A.dylib                     0x00007fff6c3ea805 objc_exception_throw + 48
    2   CoreFoundation                      0x00007fff361a230c -[NSException raise] + 9
    3   Foundation                          0x00007fff388f86c4 -[NSObject(NSKeyValueCoding) valueForUndefinedKey:] + 222
    4   Foundation                          0x00007fff3876f8fd -[NSObject(NSKeyValueCoding) valueForKey:] + 317
    …
    */
}
```

For details see the Example app.

## Tests

The library is well-tested with the coverage percentage of 94.4%, which cannot be improved since the missing parts (a single line) should never be reached.
