import SwiftUI

struct Section<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let text: LocalizedStringKey
    var content: () -> Content
    
    init(_ text: String, @ViewBuilder content: @escaping () -> Content) {
        self.text = LocalizedStringKey(text)
        self.content = content
    }
    var body: some View {
        VStack{
            Text(text).font(.footnote).bold().textCase(.uppercase).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(colorScheme == .dark ? Color(.white) : .black).padding(.leading)
            VStack(spacing: 0, content: content).background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
        }.padding(.top)
    }
}

struct ProfileSection_Previews: PreviewProvider {
    static var previews: some View {
        Section("Section"){}
    }
}
