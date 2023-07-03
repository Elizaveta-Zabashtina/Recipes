import SwiftUI

struct StepFormView: View {
    @State private var stepText = ""
    @Binding var stepNumber: Int
    var body: some View {
        Form {
            HStack {
                Button {
                    //
                } label: {
                    Text("Шаг \(stepNumber)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                }   .frame(maxWidth: 60, alignment: .leading).cornerRadius(15)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                    .background(.yellow)
                    .cornerRadius(15)
                Spacer()
                Button {
                    //
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.yellow)
                }
            } .padding(20)
            Row {
                TextField("Например: Почистите овощи", text: $stepText)
            }
            VStack {
                Text("Фото шага")
                Button {
                    //
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
            }
        }
    }
}

struct StepFormView_Previews: PreviewProvider {
    static var previews: some View {
        StepFormView(stepNumber: .constant(1))
    }
}
