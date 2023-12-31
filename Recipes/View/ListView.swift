import SwiftUI
import RealmSwift

struct ListView: View {
    @State var searchText = ""
    @State var selectedSort = "created"
    @State var selectedCategory = Category()
    @State var selectedIngredients: [Ingredient] = []
    @ObservedResults(Recipe.self) var recipes
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        HStack(alignment: .bottom) {
                            NavigationLink {
                                FilterView(selectedCategory: $selectedCategory,
                                           selectedIngredients: $selectedIngredients)
                            } label: {
                                HStack {
                                    Image(systemName: "slider.horizontal.3")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                    Text("Фильтры")
                                        .frame(width: 100, height: 30)
                                } .foregroundColor(.yellow)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(15)
                            }
                            Picker("Сортировка", selection: $selectedSort) {
                                Text("По имени").tag("name")
                                Text("По дате добавления").tag("created")
                            }
                            .frame(width: 140, height: 30)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(15)
                        } .searchable(text: $searchText, collection: $recipes, keyPath: \.name)
                        VStack {
                            if selectedCategory.name == "" && selectedIngredients.isEmpty {
                                ForEach(recipes.sorted(byKeyPath: selectedSort), id: \.id) { item in
                                    CardItem(cardItem: item) {
                                        $recipes.remove(item)
                                    }
                                }
                            } else {
                                ForEach(recipes.where {(
                                    $0.category == selectedCategory ||
                                    $0.ingredients.containsAny(in: selectedIngredients)
                                )}, id: \.id) { item in
                                    CardItem(cardItem: item) {
                                        $recipes.remove(item)
                                    }
                                }
                            }
                        }
                    }
                }
                NavigationLink {
                    CreateRecipeView()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 56, height: 56)
                            .foregroundColor(.yellow)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                } .offset(x: -20, y: -1)
            }
        }
    }
}
struct CardItem: View {
    @State var offsetX: CGFloat = 0
    @State var uiImage = UIImage()
    var cardItem: Recipe
    var onDelete: () -> Void
    var body: some View {
        NavigationView {
            ZStack(alignment: .trailing) {
                removeImage()
                NavigationLink {
                    RecipeInformationView(recipe: cardItem)
                } label: {
                    VStack(spacing: 10) {
                        uiImage.getImage(fileName: cardItem.image)?
                            .resizable()
                            .frame(width: 350, height: 250)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                        Text(cardItem.name)
                            .textCase(.uppercase)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .foregroundColor(.black)
                        HStack {
                            Image("portionsCount")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                            Text(String(cardItem.numberOfServings) + " порций")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                    }
                    .offset(x: offsetX)
                    .gesture(DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                offsetX = value.translation.width
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                if screenSize().width * 0.7 < -value.translation.width {
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    withAnimation {
                                        offsetX = -screenSize().width
                                        onDelete()
                                    }
                                } else {
                                    offsetX = .zero
                                }
                            }
                        }
                    )
                }
            }
        }
    }
    @ViewBuilder
    func removeImage() -> some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 10, height: 10)
            .offset(x: 30)
            .offset(x: offsetX * 0.5)
            .scaleEffect(CGSize(width: 0.1 * -offsetX * 0.08,
                                height: 0.1 * -offsetX * 0.08))
    }
}

extension View {
    func screenSize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
