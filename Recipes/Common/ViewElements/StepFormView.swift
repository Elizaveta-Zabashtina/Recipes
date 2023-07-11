import SwiftUI

struct StepFormView: View {
    @State var stepNumber: Int
    @State var text = ""
    @State var isPickerShow = false
    @State var image = UIImage(systemName: "camera")!
//    @Binding var recipeSteps: [RecipeStep]
 //   @State private var recipeStep = RecipeStep()
   // var onDelete: () -> Void
    var body: some View {
        Form {
            HStack {
                Text("Шаг \(stepNumber)")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: 60, alignment: .leading).cornerRadius(15)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                    .background(.yellow)
                    .cornerRadius(15)
                Spacer()
                Button {
                   // onDelete()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.yellow)
                }
            } .padding(20)
            Row {
                TextField("Например: Почистите овощи", text: $text)
            }
            VStack {
                Text("Фото шага")
                Button {
                    isPickerShow.toggle()
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 52, height: 42)
                            .foregroundColor(Color(UIColor.darkGray))
                        Text("Добавить фото")
                            .fontWeight(.light)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                .background(.yellow)
                .cornerRadius(15)
                .sheet(isPresented: $isPickerShow) {
                    ImagePicker(image: $image)
                }
            }
        }
    }
}
