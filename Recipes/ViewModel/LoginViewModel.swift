import Foundation
import UIKit

@MainActor class LoginViewModel: NSObject, ObservableObject {
    @Published var isLogin = false
    @Published var token = "" {
        didSet {
            isLogin = true
        }
    }

}
