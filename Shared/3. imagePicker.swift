//
//  3. imagePicker.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/05/31.
//

import SwiftUI

struct MainView3: View {
    
    @State private var selectedImage: UIImage?
    @State var shouldShowImagePicker: Bool = false
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage { //👉 이미지가 있을 때만 이미지를 띄운다.
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Button { //👉 ImagePicker를 모달로 띄우는 버튼
                shouldShowImagePicker = true
            } label: {
                Text("Pick Image")
            }
        }
        .sheet(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}

//✅ UIViewControllerRepresentable은 VC의 View를 SwiftUI로 보여줄 수 있게하는 역할을 한다.
    //👉 아래 3가지의 메소드를 필수로 가져야 한다.
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
        //👉 현재 View에서 이미지를 골라서 상위 View의 이미지를 바꿀 것이므로 Binding
    @Environment(\.presentationMode) var mode
        //👉 뷰를 구성하는 각종 환경 정보를 조작할 수 있는 변수를 선언하게 해주는 property wrapper
    
    //✅ SwiftUI의 context 안에서 사용할 VC를 만드는 함수
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
            //👉 picker의 delegate method들의 구현은 Coordinator에 되어 있다!
        return picker
    }
    
    //✅ VC에서 발생한 동작을 SwiftUI로 연결해주는 역할을 함.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //✅ VC를 업데이트할 때 사용하는 함수
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //🤔 업데이트를 안 할 것이면 비워 두어도 된다.
    }
    
    //✅ Coordinator 클래스에 UIImagePickerController를 사용하기 위해 지켜야할 protocol들을 정의한다.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        //✅ 이미지 골랐을 때 수행할 메소드 정의 (protocol에 정의되어 있음)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}
