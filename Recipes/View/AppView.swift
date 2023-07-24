import SwiftUI

struct AppView: View {
    @ObservedObject var createRecipeViewModel = CreateRecipeViewModel()
    var body: some View {
        ListView()
            .environmentObject(createRecipeViewModel)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
