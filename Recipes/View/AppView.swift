import SwiftUI

struct AppView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        Image("")
                        VStack {
                            Text("")
                            Text("")
                        }
                    }
                }
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
