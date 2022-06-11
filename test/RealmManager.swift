//
//  RealmManager.swift
//  test
//
//  Created by Masakaz Ozaki on 2022/06/10.
//

import Foundation
import RealmSwift

final class RealmManager: NSObject {
    let realm = try! Realm()

    func getAllRecords<T: RealmFetchable> (type: T) -> Results<T> {
        realm.objects(T.self)
    }

    func getFilteredRecords<T: IdentifiableObject>(predicate: NSPredicate, type: T) -> Results<T> {
        let results = realm.objects(T.self)
        return results.filter(predicate)
    }

    func getRecord<T: IdentifiableObject>(id: String, type: T) -> T? {
        self.getFilteredRecords(predicate: NSPredicate(format: "id == %@", "\(id)"), type: T()).first
    }

    func createTestRecord<T: IdentifiableObject>(record: T) {
        try! realm.write {
            realm.add(record)
        }
    }

    func updateRecord<T: IdentifiableObject>(id: String, newRecord: T) {
        let results = realm.objects(T.self)
        guard var oldRecord = results.filter(NSPredicate(format: "id == %@", "\(id)")).first else { return }
        try! realm.write {
            oldRecord = newRecord
            oldRecord.id = id
        }
    }

    func deleteRecord<T: IdentifiableObject>(id: String, type: T) {
        guard let record = self.getRecord(id: id, type: type) else { return }
        try! realm.write {
            realm.delete(record)
        }
    }

    func deleteAllRecords() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
