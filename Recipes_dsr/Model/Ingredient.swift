import Foundation
import RealmSwift

class Ingredient: Object {
    dynamic var id  = UUID()
    dynamic var name = ""
    dynamic var measure = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getIngredientObject(id: UUID, name: String, measure: String) -> Ingredient {
        let ingridient = Ingredient()
        
        ingridient.id = id
        ingridient.name = name
        ingridient.measure = measure
        
        return ingridient
    }
}
