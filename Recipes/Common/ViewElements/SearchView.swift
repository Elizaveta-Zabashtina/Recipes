import Foundation
import SwiftUI
import RealmSwift

struct SearchView: View {
    @ObservedResults(Category.self) var categories
    var body: some View {
        Form {
            Section("Тип блюда") {
                List {
                    ForEach(categories) { category in
                        VStack {
                            Button {
                              //
                            } label: {
                                Text(category.name)
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            Section("Ингредиент") {
            }
        }
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
