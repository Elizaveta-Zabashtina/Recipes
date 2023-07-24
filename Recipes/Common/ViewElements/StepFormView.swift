import SwiftUI
import RealmSwift

struct StepFormView: View {
    @State var isPickerShow = false
    @State var showAlert = false
    @State private var recipeStep = RecipeStep()
    @Binding var recipeSteps: [RecipeStep]
    @State var stepImage: UIImage?
    @ObservedResults(RecipeStep.self) var steps
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var createRecipeViewModel: CreateRecipeViewModel
    var body: some View {
        NavigationStack {
            Form {
                VStack(spacing: 20) {
                    Text("Шаг \(recipeSteps.count + 1)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(maxWidth: 60, alignment: .leading).cornerRadius(15)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                        .background(.yellow)
                        .cornerRadius(15)
                    Row {
                        TextField("Например: Почистите овощи", text: $recipeStep.step)
                    }
                    VStack {
//                        if let stepImage = createRecipeViewModel.stepImages?[recipeStep.number - 1] {
//                            Image(uiImage: stepImage)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .cornerRadius(15)
//                                .padding(.leading, 20)
//                                .padding(.trailing, 20)
                            if let stepImage = stepImage {
                                Image(uiImage: stepImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .cornerRadius(15)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                        } else {
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
                            } .padding(.top, 20)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                                .background(.yellow)
                                .cornerRadius(15)
                        }
                    } .sheet(isPresented: $isPickerShow) {
                        ImagePicker(image: $stepImage)
                        }
                }
                    Button {
                        if recipeStep.step.count == 0 {
                            showAlert.toggle()
                        } else {
                         //   createRecipeViewModel.stepImages?.append(stepImage)
                            let path = "images/steps/\(recipeStep.id).jpg"
                            guard (stepImage?.save(at: .documentDirectory,
                                                     pathAndImageName: path)) != nil else { return }
                            recipeStep.image = path
                            recipeStep.number = recipeSteps.count + 1
                            recipeSteps.append(recipeStep)
                            $steps.append(recipeStep)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Сохранить шаг")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                    } .frame(maxWidth: 300, alignment: .leading).cornerRadius(15)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                        .background(.yellow)
                        .cornerRadius(15)
                } .alert(Text("Пустые поля!"), isPresented: $showAlert, actions: {})
            }
    }
}

struct StepItem: View {
    var stepItem: RecipeStep
    @State var uiImage = UIImage()
    var onDelete: () -> Void
    var body: some View {
        Form {
            HStack {
                Text("Шаг \(stepItem.number)")
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
                    onDelete()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.yellow)
                }
            } .padding(20)
            Row {
                Text(stepItem.step)
            }
            uiImage.getImage(fileName: stepItem.image)?
                .resizable()
                .frame(width: 350, height: 200)
                .cornerRadius(15)
                .padding(.horizontal, 20)
        }
    }
}
