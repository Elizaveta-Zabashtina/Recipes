import SwiftUI
import RealmSwift

struct ListCategoryView: View {
    @ObservedResults(Category.self) var categories
    @Environment(\.presentationMode) var presentationMode
    @Binding var recipeCategory: Category
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    VStack {
                        Button {
                            self.recipeCategory = category
                            presentationMode.wrappedValue.dismiss()
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
