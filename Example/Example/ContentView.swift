//
//  ContentView.swift
//  Example
//
//  Created by Kristof Kalai on 2023. 03. 12..
//

import ExceptionCatcher
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: exceptionTestMethod)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func exceptionTestMethod() {
    let result = ExceptionCatcher.catch {
        final class Foo: NSObject {}
        Foo().value(forKey: "nope")
    }
    print(result)
}
