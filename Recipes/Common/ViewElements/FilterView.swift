import SwiftUI
import RealmSwift

struct FilterView: View {
    @ObservedResults(Category.self) var categories
    @ObservedResults(Ingredient.self) var ingredients
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCategory: Category
    @Binding var selectedIngredients: [Ingredient]
    var body: some View {
        Form {
            Section("Категории") {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(categories) { category in
                            LazyHStack {
                                Button {
                                    self.selectedCategory = category
                                } label: {
                                    Text(category.name)
                                        .foregroundColor(.black)
                                        .frame(alignment: .leading)
                                        .padding(.top, 10)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                        .padding(.bottom, 10)
                                        .background(.yellow)
                                        .cornerRadius(15)
                                }
                            }
                        }
                        
                    } .padding()
                } .frame(height: 50)
            }
            Section("Ингредиенты") {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(ingredients) { ingredient in
                            LazyHStack {
                                Button {
                                    selectedIngredients.append(ingredient)
                                } label: {
                                    Text(ingredient.name)
                                        .foregroundColor(.black)
                                        .frame(alignment: .leading)
                                            .padding(.top, 10)
                                            .padding(.leading, 20)
                                            .padding(.trailing, 20)
                                            .padding(.bottom, 10)
                                            .background(.yellow)
                                            .cornerRadius(15)
                                }
                            }
                        }
                    } .padding()
                } .frame(height: 50)
            }
        }
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Применить")
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        } .frame(maxWidth: 300, alignment: .leading).cornerRadius(15)
            .padding(.top, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 10)
            .background(.yellow)
            .cornerRadius(15)
    }
}
