import SwiftUI

struct ContentView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var listViewModel = ListViewModel()
    @ObservedObject var addingIngredientViewModel = AddingIngredientViewModel()
    var body: some View {
//        LoginView()
//            .ignoresSafeArea(.all)
        ZStack {
            if listViewModel.isShowCreateView {
                CreateRecipeView()
                    .environmentObject(listViewModel)
                    .environmentObject(addingIngredientViewModel)
            } else {
                ListView()
                    .environmentObject(listViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
