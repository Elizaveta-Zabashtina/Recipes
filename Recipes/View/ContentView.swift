import SwiftUI

struct ContentView: View {
//    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var createRecipeViewModel = CreateRecipeViewModel()
    var body: some View {
//        if loginViewModel.isLogin {
//        ListView()
//            }
        ListView()
            .environmentObject(createRecipeViewModel)
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
