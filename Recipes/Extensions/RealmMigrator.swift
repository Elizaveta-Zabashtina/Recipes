import Foundation
import RealmSwift

class RealmMigrator {
    init() {
        updateRealmSchema()
    }
    func updateRealmSchema() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 1
  //      config.inMemoryIdentifier = "fff878"
        _ = try? Realm(configuration: config)
        let configCheck = Realm.Configuration()
        Realm.Configuration.defaultConfiguration = config
        _ = try? Realm()
        do {
             let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch {
            print(error)
        }
    }
}
