import SwiftUI
import RealmSwift

struct ListView: View {
    @State var searchText = ""
    @EnvironmentObject var listViewModel: ListViewModel
    @ObservedResults(Recipe.self) var recipes
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 15, height: 15)
                        TextField("Поиск по ингредиентам", text: $searchText)
                            .frame(width: 300)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(15)
                    Button {
                        //
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("Фильтры")
                                .frame(width: 300)
                        } .foregroundColor(.yellow)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(15)
                    }
                    VStack(spacing: 20) {
                        ForEach(recipes, id: \.id) { item in
                            CardItem(cardItem: item) {
                                $recipes.remove(item)
                            }
                        }
                    }
                }
            }
            Button {
                listViewModel.isShowCreateView.toggle()
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
            }.offset(x: -20, y: -1)
        }
    }
}
struct CardItem: View {
    @State var offsetX: CGFloat = 0
    var cardItem: Recipe
    @EnvironmentObject var listViewModel: ListViewModel
    var onDelete: () -> Void
    var body: some View {
        ZStack(alignment: .trailing) {
            removeImage()
            Button {
                listViewModel.isShowRecipeInfromationView.toggle()
            } label: {
                VStack(spacing: 10) {
                    Image("burger")
                        .resizable()
                        .frame(width: 350, height: 200)
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
                    .frame(maxWidth: .infinity, alignment: .leading)              .padding(.leading, 30)
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
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
