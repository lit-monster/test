//
//  NSPredicate+Initializers.swift
//  test
//
//  Created by Masakaz Ozaki on 2022/06/11.
//

import Foundation

public extension NSPredicate {

    private convenience init(expression property: String, _ operation: String, _ value: AnyObject) {
        self.init(format: "\(property) \(operation) %@", argumentArray: [value])
    }

    convenience init(_ property: String, equal value: AnyObject) {
        self.init(expression: property, "=", value)
    }

    convenience init(_ property: String, notEqual value: AnyObject) {
        self.init(expression: property, "!=", value)
    }

    convenience init(_ property: String, equalOrGreaterThan value: AnyObject) {
        self.init(expression: property, ">=", value)
    }

    convenience init(_ property: String, equalOrLessThan value: AnyObject) {
        self.init(expression: property, "<=", value)
    }

    convenience init(_ property: String, greaterThan value: AnyObject) {
        self.init(expression: property, ">", value)
    }

    convenience init(_ property: String, lessThan value: AnyObject) {
        self.init(expression: property, "<", value)
    }
}
