import SwiftUI

struct ContentView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    var body: some View {
        LoginView()
            .ignoresSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
