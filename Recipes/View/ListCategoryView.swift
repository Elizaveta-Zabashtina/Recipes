import SwiftUI
import RealmSwift

struct ListCategoryView: View {
  //  @State var text = ""
    @ObservedResults(Category.self) var categories
    @Binding var recipeCategory: String
    var body: some View {
//                ScrollView {
//                    Text("Категории")
//                        .font(.title)
//                        .bold()
//                    TextField("Категория", text: $text)
//                    Button {
//                        addItem()
//                    } label: {
//                        Text("Добавить")
//                    }
//                    List {
//                        ForEach(categories, id: \.id) { category in
//                            Button {
//                                //
//                            } label: {
//                                Text(category.name)
//                            }
//                        }
//                    }
//                }
        NavigationView {
            List {
                ForEach(categories) { category in
                    Button {
                        self.recipeCategory = category.name
                    } label: {
                        Text(category.name)
                            .foregroundColor(.yellow)
                    }
                }
            } .navigationTitle("Категории")
        }
    }
//    func addItem() {
//            let category = Category()
//            category.name = text
//            $categories.append(category)
//        }
}

//struct ListCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListCategoryView(recipeCategory: "Десерты")
//    }
//}
