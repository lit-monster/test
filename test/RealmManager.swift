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

    func getFilteredRecords<T: Object>(predicate: NSPredicate) -> Results<T> {
        let results = realm.objects(T.self)
        return results.filter(predicate)
    }

    func createTestRecord<T: Object>(record: T) {
        try! realm.write {
            realm.add(record)
        }
    }

    func updateRecord<T: Object>(id: UUID, newRecord: T) {
        let results = realm.objects(T.self)
        guard var oldRecord = results.filter(NSPredicate(format: "id == %@", "\(id)")).first else {
            return 
        }
        try! realm.write {
            oldRecord = newRecord
        }
    }

    func deleteRecord<T: Object>(record: T) {
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
