//
//  Command.swift
//  DeclarativeTVC
//
//  Created by Dmitry Kocherovets on 02.11.2019.
//  Copyright © 2019 Dmitry Kocherovets. All rights reserved.
//

import Foundation

class Command: Codable {

    init(id: String = "unnamed",
         file: StaticString = #file,
         function: StaticString = #function,
         line: Int = #line,
         action: @escaping () -> ())
    {
        self.id = id
        self.action = action
        self.function = function
        self.file = file
        self.line = line
    }

    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let id: String

    private let action: () -> ()

    func perform() {
        print(self.debugQuickLookObject() ?? "")
        action()
    }

    static let nop = Command { }

    /// Support for Xcode quick look feature.
    @objc
    func debugQuickLookObject() -> AnyObject? {
        return """
            ---COMMAND---
            type: \(String(describing: type(of: self)))
            id: \(id)
            file: \(file)
            function: \(function)
            line: \(line)
            """ as NSString
    }

    required convenience init(from decoder: Decoder) throws {
        self.init { }
    }

    func encode(to encoder: Encoder) throws { }
}

extension Command: Equatable {

    static func == (lhs: Command, rhs: Command) -> Bool {
        return true
    }
}

extension Command: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
}

final class CommandWith<T> {
    init(id: String = "unnamed",
         file: StaticString = #file,
         function: StaticString = #function,
         line: Int = #line,
         action: @escaping (T) -> ()) {

        self.action = action

        self.id = id
        self.function = function
        self.file = file
        self.line = line
    }

    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let id: String

    let action: (T) -> ()

    func perform(with value: T) {
        if let debugQuickLookObject = debugQuickLookObject() {
            print("\(String(describing: debugQuickLookObject))\nparameter: \(value)")
        }
        action(value)
    }

    /// Support for Xcode quick look feature.
    @objc
    func debugQuickLookObject() -> AnyObject? {
        return """
               ---COMMAND---
               type: \(String(describing: type(of: self)))
               id: \(id)
               file: \(file)
               function: \(function)
               line: \(line)
               """ as NSString
    }

    func bind(to value: T) -> Command {
        return Command { self.perform(with: value) }
    }

    static var nop: CommandWith {
        return CommandWith { _ in }
    }

    func dispatched(on queue: DispatchQueue) -> CommandWith {
        return CommandWith { value in
            queue.async {
                self.perform(with: value)
            }
        }
    }

    func then(_ another: CommandWith) -> CommandWith {
        return CommandWith { value in
            self.perform(with: value)
            another.perform(with: value)
        }
    }
}

extension CommandWith: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
}

extension CommandWith: Equatable {

    static func == (lhs: CommandWith, rhs: CommandWith) -> Bool {
        return true
    }
}


extension CommandWith: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init { _ in }
    }

    func encode(to encoder: Encoder) throws { }
}

extension CommandWith {
    func map<U>(transform: @escaping (U) -> T) -> CommandWith<U> {
        return CommandWith<U> { u in
            self.perform(with: transform(u))
        }
    }
}

