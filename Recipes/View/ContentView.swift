import SwiftUI

struct ContentView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var listViewModel = ListViewModel()
    @ObservedObject var createRecipeViewModel = CreateRecipeViewModel()
    var body: some View {
//        if loginViewModel.isLogin {
            ZStack {
                if listViewModel.isShowCreateView {
                    CreateRecipeView()
                        .environmentObject(listViewModel)
                        .environmentObject(createRecipeViewModel)
                } else {
                    ListView()
                        .environmentObject(listViewModel)
                }
            }
//        } else {
//            LoginView()
//                .ignoresSafeArea(.all)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
