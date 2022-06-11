//
//  Plus.swift
//  test
//
//  Created by Masakaz Ozaki on 2022/06/09.
//

import Foundation
import RealmSwift

protocol IdentifiableObject: Object {
    dynamic var id: String { get set }
}

class Plus: Object, IdentifiableObject {
    @objc dynamic var id: String = "\(UUID())"
    @objc dynamic var date: Date = .init()
    @objc dynamic var japanese: Int = 0
    @objc dynamic var math: Int = 0
    @objc dynamic var english: Int = 0
    @objc dynamic var science: Int = 0
    @objc dynamic var socialStudies: Int = 0
    @objc dynamic var ranking: Int = 0
    @objc dynamic var name: String = ""

}
