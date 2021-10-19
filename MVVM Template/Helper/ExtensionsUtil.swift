//
//  ExtensionsUtil.swift
//  Sheikh Zayed
//
//  Created by ios on 1/16/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto


extension UICollectionView {

var centerPoint : CGPoint {

    get {
        return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
    }
}

var centerCellIndexPath: IndexPath? {

    if let centerIndexPath: IndexPath  = self.indexPathForItem(at: self.centerPoint) {
        return centerIndexPath
    }
    return nil
}
}
// Defines types of hash string outputs available

public enum HashOutputType {
    // standard hex string output
    case hex
    // base 64 encoded string output
    case base64
}

// Defines types of hash algorithms available
public enum HashType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    
    var length: Int32 {
        switch self {
        case .md5: return CC_MD5_DIGEST_LENGTH
        case .sha1: return CC_SHA1_DIGEST_LENGTH
        case .sha224: return CC_SHA224_DIGEST_LENGTH
        case .sha256: return CC_SHA256_DIGEST_LENGTH
        case .sha384: return CC_SHA384_DIGEST_LENGTH
        case .sha512: return CC_SHA512_DIGEST_LENGTH
        }
    }
}

public extension String {
    
    
    func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {
        
        // convert string to utf8 encoded data
        guard let message = data(using: .utf8) else { return nil }
        return message.hashed(type, output: output)
    }
}

extension Data {
    
    
    public func hashWithRSA2048Asn1Header(_ type: HashType, output: HashOutputType = .hex) -> String? {
        
        let rsa2048Asn1Header:[UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        var headerData = Data(rsa2048Asn1Header)
        headerData.append(self)
        
        return hashed(type, output: output)
    }
    
    public func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {
        
        // setup data variable to hold hashed value
        var digest = Data(count: Int(type.length))
        
        _ = digest.withUnsafeMutableBytes{ digestBytes -> UInt8 in
            self.withUnsafeBytes { messageBytes -> UInt8 in
                if let mb = messageBytes.baseAddress, let db = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let length = CC_LONG(self.count)
                    switch type {
                    case .md5: CC_MD5(mb, length, db)
                    case .sha1: CC_SHA1(mb, length, db)
                    case .sha224: CC_SHA224(mb, length, db)
                    case .sha256: CC_SHA256(mb, length, db)
                    case .sha384: CC_SHA384(mb, length, db)
                    case .sha512: CC_SHA512(mb, length, db)
                    }
                }
                return 0
            }
        }
        
        // return the value based on the specified output type.
        switch output {
        case .hex: return digest.map { String(format: "%02hhx", $0) }.joined()
        case .base64: return digest.base64EncodedString()
        }
    }
}

public extension UIView {
    
    func fadeIn(duration: TimeInterval, alpha: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        })
    }
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    func shakeView(viewToShake: UIView){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x - 7, y: viewToShake.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x + 7, y: viewToShake.center.y))
        
        viewToShake.layer.add(animation, forKey: "position")
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func applyBottomCornerLeft(BottomLeftcornerRadius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: BottomLeftcornerRadius, height: BottomLeftcornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyBottomCornerRight(BottomRightcornerRadius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: BottomRightcornerRadius, height: BottomRightcornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func applyBottomCorner( BottomcornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomRight , .bottomLeft], cornerRadii: CGSize(width: BottomcornerRadius, height: BottomcornerRadius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }

    func applyTopCornerLeft(TopLeftcornerRadius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: TopLeftcornerRadius, height: TopLeftcornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyTopCornerRight(TopRightcornerRadius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: TopRightcornerRadius, height: TopRightcornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func applyTopCorner( TopcornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: TopcornerRadius, height: TopcornerRadius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }

    
}

func adjustLabels(label: UILabel){
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.7
    label.numberOfLines = 2 // or 1
}

extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
    
}

extension String {
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func random(_ n: Int) -> String
    {
        let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        
        var s = ""
        
        for _ in 0..<n
        {
            let r = Int(arc4random_uniform(UInt32(a.count)))
            
            s += String(a[a.index(a.startIndex, offsetBy: r)])
        }
        
        return s
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    var inverted: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a)
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}


extension Date {
    
    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
}

extension CIImage {
    var image: UIImage? {
        let image = UIImage(ciImage: self)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: image.size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension UIImage {
    func applying(saturation value: NSNumber) -> UIImage? {
        return CIImage(image: self)?
            .applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: value])
            .image
    }  // Swift 3 uses withInputParameters instead of parameters
    var grayscale: UIImage? {
        return applying(saturation: 0)
    }
    
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Float) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue){
                if data.count < Int(sizeInBytes) {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < Int(sizeInBytes)) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
}

extension UIImageView {
    func setImageColor(color: UIColor) -> UIImage? {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
        
        return self.image
    }
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIImageView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIImageView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIImageView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIImageView.kRotationAnimationKey)
        }
    }
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}



extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
    
    public func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.canOpenURL(URL(string: url)!)
                return
            }
        }
    }
}

extension UIImage {
    
    /**
     Creates the UIImageJPEGRepresentation out of an UIImage
     @return Data
     */
    
    func generateJPEGRepresentation() -> Data? {
        
        let newImage = self.copyOriginalImage()
        let newData = newImage.jpegData(compressionQuality: 1.0)
        
        return newData
    }
    
    /**
     Copies Original Image which fixes the crash for extracting Data from UIImage
     @return UIImage
     */
    
    private func copyOriginalImage() -> UIImage {
        UIGraphicsBeginImageContext(self.size);
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return newImage!
    }
}

extension UIToolbar {
    
    func ToolbarPicker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        if UserDefaults.standard.bool(forKey: "isDarkMode"){
            toolBar.tintColor = UIColor.white
        }
        //toolBar.backgroundColor = Constants.anotherBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

extension UINavigationController {
    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        pushViewController(viewController, animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func pop(transitionType type: CATransitionType = .push, direction: CATransitionSubtype = .fromBottom, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, direction: direction, duration: duration)
        self.popViewController(animated: false)
    }

    /**
     Push a new view controller on the view controllers's stack.

     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func push(viewController vc: UIViewController, transitionType type: CATransitionType = .push, direction: CATransitionSubtype = .fromBottom,  duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, direction: direction, duration: duration)
        self.pushViewController(vc, animated: false)
    }

    private func addTransition(transitionType type: CATransitionType = .push, direction: CATransitionSubtype = .fromBottom, duration: CFTimeInterval = 0.3) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        transition.subtype = direction
        self.view.layer.add(transition, forKey: kCATransition)
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() -> Int {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        return closestCellIndex
    }
}


extension UILabel {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}


