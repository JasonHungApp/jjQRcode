//
//  ViewController_v3.swift
//  jjQRcode
//
//  Created by jasonhung on 2024/10/8.
//



import UIKit
import CoreImage


class ViewController_v3: UIViewController {
   
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // 生成 QR code 並顯示在畫面上
            if let qrCodeImage = generateQRCode(from: "https://example.com") {
                let qrImageView = UIImageView(image: qrCodeImage)
                qrImageView.center = self.view.center
                self.view.addSubview(qrImageView)
                
                // 在 QR code 周圍加入動畫
                addAnimatedBorders(around: qrImageView)
            }
        }
        
        // 生成 QR code 圖片
        func generateQRCode(from string: String) -> UIImage? {
            let data = string.data(using: String.Encoding.ascii)
            
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                filter.setValue("H", forKey: "inputCorrectionLevel")
                
                if let qrCodeImage = filter.outputImage {
                    let transform = CGAffineTransform(scaleX: 10, y: 10) // 放大 QR code
                    let scaledQRCode = qrCodeImage.transformed(by: transform)
                    return UIImage(ciImage: scaledQRCode)
                }
            }
            return nil
        }
        
        // 在 QR code 周圍加入動畫
        func addAnimatedBorders(around qrCodeView: UIImageView) {
            let borderFrame = CGRect(x: qrCodeView.frame.origin.x - 20,
                                     y: qrCodeView.frame.origin.y - 20,
                                     width: qrCodeView.frame.size.width + 40,
                                     height: qrCodeView.frame.size.height + 40)
            let borderView = UIView(frame: borderFrame)
            borderView.layer.borderWidth = 5
            borderView.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview(borderView)
            
            // 加入動畫：邊框顏色變換
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           options: [.repeat, .autoreverse],
                           animations: {
                borderView.layer.borderColor = UIColor.blue.cgColor
            }, completion: nil)
        }
    }
