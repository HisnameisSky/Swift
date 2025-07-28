//
//  AddPersonView.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import CoreLocation
import SwiftUI

//人物の追加専用の画面の構造体
struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var location: CLLocationCoordinate2D?
    
    @State private var hasLocationSwitchOn = false
    @State private var isShowingImagePicker = false
    @State private var isShowingConfirmAlert = false
    
    let locationFetcher = LocationFetcher()
    
    var hasImageAndName: Bool {
        inputImage != nil && !name.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                //画像を選べる個体
                Section("Image") {
                    if inputImage != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        EmptyImagePlaceholder(color: .blue)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                }
                //画像を選んだ場合のプロパティ
                .onChange(of: inputImage) { newValue in
                    setImage(uiImage: newValue)
                }
                
                Section("Name") {
                    TextField("Person's name", text: $name)
                }
                
                Section("Location") {
                    //場所の情報保存
                    Toggle("Save Location?",
                           isOn: $hasLocationSwitchOn.animation())
                    .onChange(of: hasLocationSwitchOn) { newValue in
                        if newValue == true { locationFetcher.start() }
                        else { location = nil }
                    }
                    //座標の有無に応じて表示されるボタンとそれにまつわる機能
                    if hasLocationSwitchOn {
                        Button {
                            location = locationFetcher.lastKnownLocation
                            
                            isShowingConfirmAlert = true
                        } label: {
                            Label(
                                "Share My Current Location",
                                systemImage: "location"
                            )
                        }
                    }
                }
            }
            //表示される通知の設定
            .alert("Location saved!", isPresented: $isShowingConfirmAlert) {
                Button("OK") { }
            } message: {
                Text("Your current location will be saved to remind you where you met this person.")
            }
            //申請書類型
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                Button {
                    // 情報の保存
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(
                        compressionQuality: 0.8
                    ) else { return }
                    //人物の名前と座標情報の定義
                    let person = Person(
                        name: name,
                        jpegData: jpegData,
                        latitude: location?.latitude,
                        longitude: location?.longitude
                    )
                    
                    viewModel.addPerson(person)
                    dismiss()
                } label: {
                    Text("Save")
                }
                //いじられなくなるプロパティ
                .disabled(!hasImageAndName)
            }
            //題名
            .navigationTitle("Add a new person")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    //画像を選べる個体を押せばの機能
    func setImage(uiImage: UIImage?) {
        guard let uiImage = uiImage else { return }
        
        image = Image(uiImage: uiImage)
    }
}
//見本専用
struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
