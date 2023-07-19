import SwiftUI
import RealmSwift

struct ListCategoryView: View {
    @ObservedResults(Category.self) var categories
    @Binding var recipeCategory: Category
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    VStack {
                        Button {
                            self.recipeCategory = category
                        } label: {
                            Text(category.name)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            } .navigationTitle("Категории")
        }
    }
}
