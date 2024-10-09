//
//  ViewController_v2.swift
//  jjQRcode
//
//  Created by jasonhung on 2024/10/8.
//

import UIKit
import CoreImage


class ViewController_v2: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 生成 QR code 矩陣
        if let qrMatrix = generateQRCodeMatrix(from: "https://example.com") {
            createAnimatedQRCode(from: qrMatrix)
        }
    }
    
    // 生成 QR code 並轉換為二維矩陣
    func generateQRCodeMatrix(from string: String) -> [[Bool]]? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            
            if let qrCodeImage = filter.outputImage {
                // QR code 是 CIImage，將其轉換成像素
                let context = CIContext()
                if let cgImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                    let width = Int(qrCodeImage.extent.size.width)
                    let height = Int(qrCodeImage.extent.size.height)
                    var qrMatrix = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)
                    
                    let pixelData = cgImage.dataProvider?.data
                    let data = CFDataGetBytePtr(pixelData)
                    
                    // 將 QR code 圖像的像素轉換成二維布林矩陣
                    for x in 0..<width {
                        for y in 0..<height {
                            let pixelIndex = (width * y + x) * 4
                            let pixelValue = data?[pixelIndex] ?? 0
                            // 黑色像素為模組，非黑色為背景
                            qrMatrix[y][x] = pixelValue == 0
                        }
                    }
                    return qrMatrix
                }
            }
        }
        return nil
    }
    
    // 創建 QR code 並為每個模組加入動畫
    func createAnimatedQRCode(from qrMatrix: [[Bool]]) {
        let moduleSize: CGFloat = 10.0 // 每個模組的大小
        let qrCodeSize = CGFloat(qrMatrix.count) * moduleSize
        let origin = CGPoint(x: (view.frame.width - qrCodeSize) / 2, y: (view.frame.height - qrCodeSize) / 2)
        
        for (y, row) in qrMatrix.enumerated() {
            for (x, isModule) in row.enumerated() {
                if isModule {
                    // 創建每個模組（小方塊）
                    let moduleView = UIView(frame: CGRect(x: origin.x + CGFloat(x) * moduleSize,
                                                          y: origin.y + CGFloat(y) * moduleSize,
                                                          width: moduleSize,
                                                          height: moduleSize))
                    moduleView.backgroundColor = .black
                    self.view.addSubview(moduleView)
                    
                    // 加入動畫
                    animateModule(moduleView)
                }
            }
        }
    }
    
    // 對每個模組加入動畫效果
    func animateModule(_ moduleView: UIView) {
        moduleView.alpha = 0.0
        let delay = Double.random(in: 0.0...1.0) // 隨機延遲時間
        
        UIView.animate(withDuration: 0.5, delay: delay, options: [.repeat, .autoreverse], animations: {
            moduleView.alpha = 1.0
        }, completion: nil)
    }
}
