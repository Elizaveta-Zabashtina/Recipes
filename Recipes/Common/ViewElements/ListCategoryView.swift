import SwiftUI
import RealmSwift

struct ListCategoryView: View {
    @State var text = ""
    @ObservedResults(Category.self) var categories
    @EnvironmentObject var createRecipeViewModel: CreateRecipeViewModel
    @Binding var recipeCategory: Category
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Button {
                        self.recipeCategory = category
                    } label: {
                        Text(category.name)
                            .foregroundColor(.yellow)
                    }
                }
            } .navigationTitle("Категории")
        }
    }
}
