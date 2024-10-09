//
//  ViewController_v1.swift
//  jjQRcode
//
//  Created by jasonhung on 2024/10/8.
//



import UIKit
import CoreImage


class ViewController_v1: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 創建 QR code 並顯示在畫面上
        if let qrCodeImage = generateQRCode(from: "https://example.com") {
            let imageView = UIImageView(image: qrCodeImage)
            imageView.center = self.view.center
            self.view.addSubview(imageView)
            
            // 在 QR code 中心加入圖片
            let logoImageView = addLogo(to: imageView, logo: UIImage(named: "logo.png")!)
            self.view.addSubview(logoImageView)
            
            // 為 Logo 加上縮放動畫
            animateLogo(logoImageView)
        }
    }
    
    // 生成 QR code 圖片
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel") // 設定容錯等級
            
            if let qrCodeImage = filter.outputImage {
                let transform = CGAffineTransform(scaleX: 10, y: 10) // 放大 QR code 圖片
                let scaledQRCode = qrCodeImage.transformed(by: transform)
                return UIImage(ciImage: scaledQRCode)
            }
        }
        return nil
    }
    
    // 在 QR code 中心加入 Logo
    func addLogo(to qrCodeImageView: UIImageView, logo: UIImage) -> UIImageView {
        let logoSize = qrCodeImageView.frame.size.width * 0.2 // Logo 大小為 QR code 寬度的 20%
        let logoImageView = UIImageView(image: logo)
        logoImageView.frame.size = CGSize(width: logoSize, height: logoSize)
        logoImageView.center = qrCodeImageView.center
        logoImageView.layer.cornerRadius = 10
        logoImageView.clipsToBounds = true
        return logoImageView
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

