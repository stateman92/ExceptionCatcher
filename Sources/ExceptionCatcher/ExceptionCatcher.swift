@_implementationOnly import Internal

public enum ExceptionCatcher {
    /// Catch an Objective-C exception.
    ///    ```
    ///    import ExceptionCatcher
    ///
    ///    final class Foo: NSObject {}
    ///
    ///    do {
    ///        let value = try ExceptionCatcher.rethrow {
    ///            Foo().value(forKey: "nope")
    ///        }
    ///        print("Value: ", value)
    ///    } catch {
    ///        print("Error: ", error.localizedDescription)
    ///        // Error: [<ExceptionCatcherTests.Foo 0x6000034c0030> valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope.
    ///    }
    ///    ```
    /// - Parameter callback: the throwing part of the code.
    /// - Returns: The value returned from the given callback.
    @discardableResult public static func rethrow<T>(callback: () throws -> T) throws -> T {
        var returnValue: T!
        var returnError: Error?

        try _ExceptionCatcher.rethrowException {
            do {
                returnValue = try callback()
            } catch {
                returnError = error
            }
        }

        if let returnError {
            throw returnError
        }

        return returnValue
    }
}

extension ExceptionCatcher {
    /// Catch an Objective-C exception.
    ///    ```
    ///    import ExceptionCatcher
    ///
    ///    final class Foo: NSObject {}
    ///
    ///    let result = ExceptionCatcher.catch {
    ///        Foo().value(forKey: "nope")
    ///    }
    ///    switch result {
    ///    case let .exception(exception):
    ///        print("Error: ", exception.description)
    ///        // Error: [<ExceptionCatcherTests.Foo 0x6000034c0030> valueForUndefinedKey:]: this class is not key value coding-compliant for the key nope.
    ///    default: break
    ///    }
    ///    ```
    /// - Parameter callback: the throwing part of the code.
    /// - Returns: The value returned from the given callback.
    @discardableResult public static func `catch`<T>(callback: () throws -> T) -> ExceptionResult<T> {
        var returnValue: T?
        var returnError: Error?

        let exception = _ExceptionCatcher.catchException {
            do {
                returnValue = try callback()
            } catch {
                returnError = error
            }
        }

        if let exception {
            return .exception(exception)
        } else if let returnError {
            return .error(returnError)
        } else if let returnValue {
            return .success(returnValue)
        }
        preconditionFailure("Either an error, an exception or a result should be presented!")
    }
}
