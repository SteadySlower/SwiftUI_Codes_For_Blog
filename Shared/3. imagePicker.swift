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
            if let selectedImage = selectedImage { //๐ ์ด๋ฏธ์ง๊ฐ ์์ ๋๋ง ์ด๋ฏธ์ง๋ฅผ ๋์ด๋ค.
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Button { //๐ ImagePicker๋ฅผ ๋ชจ๋ฌ๋ก ๋์ฐ๋ ๋ฒํผ
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

//โ UIViewControllerRepresentable์ VC์ View๋ฅผ SwiftUI๋ก ๋ณด์ฌ์ค ์ ์๊ฒํ๋ ์ญํ ์ ํ๋ค.
    //๐ ์๋ 3๊ฐ์ง์ ๋ฉ์๋๋ฅผ ํ์๋ก ๊ฐ์ ธ์ผ ํ๋ค.
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
        //๐ ํ์ฌ View์์ ์ด๋ฏธ์ง๋ฅผ ๊ณจ๋ผ์ ์์ View์ ์ด๋ฏธ์ง๋ฅผ ๋ฐ๊ฟ ๊ฒ์ด๋ฏ๋ก Binding
    @Environment(\.presentationMode) var mode
        //๐ ๋ทฐ๋ฅผ ๊ตฌ์ฑํ๋ ๊ฐ์ข ํ๊ฒฝ ์ ๋ณด๋ฅผ ์กฐ์ํ  ์ ์๋ ๋ณ์๋ฅผ ์ ์ธํ๊ฒ ํด์ฃผ๋ property wrapper
    
    //โ SwiftUI์ context ์์์ ์ฌ์ฉํ  VC๋ฅผ ๋ง๋๋ ํจ์
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
            //๐ picker์ delegate method๋ค์ ๊ตฌํ์ Coordinator์ ๋์ด ์๋ค!
        return picker
    }
    
    //โ VC์์ ๋ฐ์ํ ๋์์ SwiftUI๋ก ์ฐ๊ฒฐํด์ฃผ๋ ์ญํ ์ ํจ.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //โ VC๋ฅผ ์๋ฐ์ดํธํ  ๋ ์ฌ์ฉํ๋ ํจ์
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //๐ค ์๋ฐ์ดํธ๋ฅผ ์ ํ  ๊ฒ์ด๋ฉด ๋น์ ๋์ด๋ ๋๋ค.
    }
    
    //โ Coordinator ํด๋์ค์ UIImagePickerController๋ฅผ ์ฌ์ฉํ๊ธฐ ์ํด ์ง์ผ์ผํ  protocol๋ค์ ์ ์ํ๋ค.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        //โ ์ด๋ฏธ์ง ๊ณจ๋์ ๋ ์ํํ  ๋ฉ์๋ ์ ์ (protocol์ ์ ์๋์ด ์์)
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}
