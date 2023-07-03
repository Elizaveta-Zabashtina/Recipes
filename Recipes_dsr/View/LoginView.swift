import SwiftUI


struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var login = ""
    @State private var password = ""
    @State private var isShowingWebView: Bool = false
    
    var body: some View {
        if loginViewModel.isLogin {
            AppView()
                .environmentObject(loginViewModel)
        } else {
            VStack(spacing: 20){
                
                Spacer()
                
                Text("Welcome!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                
                Text("Sign in with social network account:")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
                
                
                Button {
                    Task {
                        isShowingWebView = true
                    }
                } label: {
                    HStack {
                        Image("VkIcon")
                        Text("Sign In with VK")
                    }
                            .frame(maxWidth: 330, alignment: .leading).cornerRadius(15)
                            .padding(.top, 2)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .padding(.bottom, 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                }
                .sheet(isPresented: $isShowingWebView) {
                    WebView(token: $loginViewModel.token)
                        }
                
               
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
