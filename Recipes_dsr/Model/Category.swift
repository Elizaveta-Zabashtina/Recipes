import Foundation
import RealmSwift

class Category: Object {
    dynamic var id  = UUID()
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getCategoryObject(id: UUID, name: String) -> Category {
        let category = Category()
        
        category.id = id
        category.name = name
        
        return category
    }
}
