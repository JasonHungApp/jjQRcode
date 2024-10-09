# 動感 QRCode 產生器 App

這是一個使用 Swift 與 UIKit 開發的動感 QRCode 產生器 App。應用程式不僅能夠生成 QRCode，還能為每個黑色模組添加動畫效果，讓 QRCode 看起來更具活力。同時支持在 QRCode 中心嵌入 logo，並且在掃描時依然能夠被鏡頭準確辨識。

## 文章介紹

這個專案的詳細介紹與教學，可以參考以下兩篇文章：

### Medium 專案介紹
**[Swift UIKit：打造活力四射的動感 QRCode](https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/swift-uikit-qrcode-5ac8b4bf2db5)**  
在 Medium 上的文章詳細說明了如何利用 CoreImage 和 UIView 動畫來設計一個動感 QRCode 產生器。

### iThome 2024 鐵人賽參賽文章
**[iOS 開發實戰 - 動感 QRCode 產生器 App：Core Image 與動畫效果聯手出擊](https://ithelp.ithome.com.tw/articles/10365118)**  
這篇文章是參加 iThome 2024 鐵人賽的 Day 25 專題，介紹了如何使用 CoreImage 與動畫效果相結合來生成並美化 QRCode。

## 功能特色
- 生成 QRCode 圖片
- 在 QRCode 圖片上加入 logo
- 動態調整 QRCode 模組的透明度，實現動畫效果
- 保持 QRCode 在被掃描時的高可辨識性

## 使用技術
- **Swift**
- **UIKit**
- **CoreImage**：生成 QRCode 圖片
- **UIView 動畫**：實現模組動畫效果

## 如何運行專案

1. 下載或 Clone 此專案：
    ```bash
    git clone https://github.com/yourusername/dynamic-qrcode-app.git
    ```

2. 使用 Xcode 開啟專案。

3. 運行程式，體驗動感 QRCode 生成器。

## 授權
此專案採用 MIT 授權條款，詳見 [LICENSE](LICENSE) 檔案。

