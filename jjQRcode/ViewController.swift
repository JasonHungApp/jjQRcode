//
//  ViewController.swift
//  jjQRcode
//
//  Created by jasonhung on 2024/10/8.
//

import UIKit
import CoreImage


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 生成 QR code 矩陣
        if let qrMatrix = generateQRCodeMatrix(from: "https://medium.com/@jasonhungapp") {
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
                    
                    let pixelData = cgImage.dataProvider?.data
                    let data = CFDataGetBytePtr(pixelData)
                    
                    var qrMatrix = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)
                    

                    
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

        // 添加外框
        let borderThickness: CGFloat = 5.0
        let borderView = UIView(frame: CGRect(x: origin.x - borderThickness,
                                              y: origin.y - borderThickness,
                                              width: qrCodeSize + 2 * borderThickness,
                                              height: qrCodeSize + 2 * borderThickness))
        borderView.layer.borderColor = UIColor.black.cgColor // 這裡可以改變框的顏色
        borderView.layer.borderWidth = borderThickness
        borderView.layer.cornerRadius = 10.0 // 可選：如果想要圓角框
        self.view.addSubview(borderView)
        
        for (y, row) in qrMatrix.enumerated() {
            for (x, isModule) in row.enumerated() {
                if isModule {
                    // 創建每個模組（小方塊）
                    let moduleView = UIView(frame: CGRect(x: origin.x + CGFloat(x) * moduleSize,
                                                          y: origin.y + CGFloat(y) * moduleSize,
                                                          width: moduleSize,
                                                          height: moduleSize))
                    moduleView.backgroundColor = .black // 預設黑色，可以根據需求調整
                    self.view.addSubview(moduleView)

                    // 加入動畫
                    animateModule(moduleView)
                }
            }
        }
        
        // 加入 logo 到 QR code 中間
        if let logoImage = UIImage(named: "logo.png") {
            addLogoToQRCode(qrCodeSize: qrCodeSize, logo: logoImage, at: origin)
        }
    }

    
    // 對每個模組加入動畫效果
    func animateModule(_ moduleView: UIView) {
        moduleView.alpha = 0.4
        let delay = Double.random(in: 0.0...1.0) // 隨機延遲時間
        
        UIView.animate(withDuration: 0.5, delay: delay, options: [.repeat, .autoreverse], animations: {
            moduleView.alpha = 1.0
        }, completion: nil)
    }
    
    // 將 logo 加入到 QR code 中間
    func addLogoToQRCode(qrCodeSize: CGFloat, logo: UIImage, at origin: CGPoint) {
        let logoImageView = UIImageView(image: logo)
        
        // 設定 logo 大小，這裡的例子是 QR code 的 1/5 大小
        let logoSize = qrCodeSize / 5
        logoImageView.frame = CGRect(
            x: origin.x + (qrCodeSize - logoSize) / 2,
            y: origin.y + (qrCodeSize - logoSize) / 2,
            width: logoSize,
            height: logoSize
        )
        
        // 設置 logo 的內容模式為縮放適配
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true // 確保圓角生效

        // 確保 logo 的背景透明
        logoImageView.backgroundColor = .clear
        
        // 將 logo 添加到 QR code 視圖中
        self.view.addSubview(logoImageView)
        
        // 為 Logo 加上縮放動畫
        animateLogo(logoImageView)
    }
    
    // 為 Logo 加上縮放動畫
    func animateLogo(_ logoImageView: UIImageView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // 放大 20%
        }, completion: nil)
    }
}
