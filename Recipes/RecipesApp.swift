import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        let realmMigrator = RealmMigrator()
        WindowGroup {
            ContentView()
        }
    }
}
