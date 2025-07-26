//
//  ContentView.swift
//  Instafilter
//
//  Created by 澄界 on 2025/07/26.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI


struct ContentView: View {
    
    //定義の概要欄
    @State private var processedImage: Image?
    @State private var intensityAmount = 0.4
    @State private var scaleAmount = 0.4
    @State private var widthAmount = 0.4
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingConfirmationDialog = false
    
    //アプリ保存用
    @AppStorage("filterCount") var filterCount = 0
    
    //評価画面の定義
    @Environment(\.requestReview) var requestReview
    let context = CIContext()
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                //画像の選択スタック
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Click to import a picture"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                //フィルターの詳細設定
                HStack {
                    Text("Intensity")
                    Spacer()
                    Slider(value: $intensityAmount)
                        .onChange(of: intensityAmount, applyProcess)
                        .disabled(processedImage == nil ? true : false)
                }
                HStack {
                    Text("Scale")
                    Spacer()
                    Slider(value: $scaleAmount)
                        .onChange(of: scaleAmount, applyProcess)
                        .disabled(processedImage == nil ? true : false)
                }
                HStack {
                    Text("Width")
                    Spacer()
                    Slider(value: $widthAmount)
                        .onChange(of: widthAmount, applyProcess)
                        .disabled(processedImage == nil ? true : false)
                }
                HStack {
                    //フィルター変更のボタン
                    Button("Change filter", action: changeFilter)
                        .disabled(processedImage == nil ? true : false)
                    Spacer()
                    if let processedImage {
                        //共有機能の実装
                        ShareLink(item: processedImage, preview: SharePreview("Processed Image", image: processedImage))
                    }
                }
            }
            .padding()
            .navigationTitle("Instafilter")
            
            //フィルター変更のボタン用
            .confirmationDialog("Change filter", isPresented: $showingConfirmationDialog) {
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Dotscreen") { setFilter(CIFilter.dotScreen()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("X-Ray") { setFilter(CIFilter.xRay()) }
                Button("Circularscreen") { setFilter(CIFilter.circularScreen()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    //追加機能の概要欄
    //フィルタ変更
    func changeFilter() {
        showingConfirmationDialog = true
    }
    //画像の読み込み
    func loadImage()  {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcess()
        }
    }
    
    //フィルタの適用
    func applyProcess() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensityAmount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensityAmount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(scaleAmount * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputWidthKey) { currentFilter.setValue(widthAmount * 10, forKey: kCIInputWidthKey) }
        //BuiltInsを弄るように試す宣言
        guard let outputImage = try currentFilter.outputImage else { return }
        guard let cgImage = try context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    //アプリ全体の設定専用
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        if filterCount % 10 == 1 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
