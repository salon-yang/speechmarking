//
//  ToastExtension.swift
//  YunTrans
//
//  Created by tony on 2019/6/10.
//  Copyright © 2019 liip. All rights reserved.
//

import UIKit

func coloredImage(image: UIImage, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIImage! {
    
    let rect = CGRect(origin: CGPoint(x: 0,y :0), size: image.size)
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    let context = UIGraphicsGetCurrentContext()
    image.draw(in: rect)
    context?.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
    context?.setBlendMode(CGBlendMode.sourceAtop)
    context?.fill(rect)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
}


class ToastUtil{
    let view:UIView
    fileprivate let textToast:TextToast
    fileprivate let speakToast:SpeakToast
    
    init(view:UIView) {
        self.view = view
        self.textToast = TextToast(view:view)
        self.speakToast = SpeakToast(view:view)
        
    }
    
    /**展示一下文字提示*/
    class func showTextToastInFewSeconds(_ message : String) {
        EWToast.showCenterWithText(text: message,duration: 1)
    }
    
    /**展示语音提示控件*/
    func showSpeakToast(){
        self.speakToast.isPicAlertToggled = true
        //self.speakToast.isReadyToCancel = false
    }
    
    /**清除语音提示控件*/
    func dissmissSpeakToast(){
        self.speakToast.isPicAlertToggled = false
    }
    
    /**展示准备取消语音识别控件*/
    func showSpeakReadyToCancelToast(){
        if self.speakToast.isPicAlertToggled{
            //self.speakToast.isReadyToCancel = true
        }
    }
    
    
    /**
    确认提示
     */
    class func makeConfirmAlert(title:String="系统提示",message:String,confirmHandler:@escaping (UIAlertAction)->())->UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "确认", style: .default,handler: confirmHandler))
        return alertController
    }
    
}

class EWToast: NSObject {
    ///Toast默认停留时间
    static let toastDispalyDuration: CGFloat = 2.0
    ///Toast背景颜色
    static let toastBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)

    var contentView: UIButton
    var duration: CGFloat = toastDispalyDuration

    init(text: String) {
        let rect = text.boundingRect(with: CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude), options:[NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.size.width + 40, height: rect.size.height + 20))
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.text = text
        textLabel.numberOfLines = 0

        contentView = UIButton(frame: CGRect(x: 0, y: 0, width: textLabel.frame.size.width, height: textLabel.frame.size.height))
        contentView.layer.cornerRadius = 2.0
        contentView.backgroundColor = EWToast.toastBackgroundColor
        contentView.addSubview(textLabel)
        contentView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        super.init()
        contentView.addTarget(self, action: #selector(toastTaped), for: .touchDown)
        ///添加通知获取手机旋转状态.保证正确的显示效果
        NotificationCenter.default.addObserver(self, selector: #selector(toastTaped), name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
    }
    @objc func toastTaped() {
        self.hideAnimation()
    }
    func deviceOrientationDidChanged(notify: Notification) {
        self.hideAnimation()
    }
    @objc func dismissToast() {
        contentView.removeFromSuperview()
    }
    func setDuration(duration: CGFloat) {
        self.duration = duration
    }
    func showAnimation() {
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 1.0
        UIView.commitAnimations()
    }
    @objc func hideAnimation() {
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dismissToast))
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 0.0
        UIView.commitAnimations()
    }

    func show() {
        let window: UIWindow = UIApplication.shared.windows.last!
        contentView.center = window.center
        window.addSubview(contentView)
        self.showAnimation()
        self.perform(#selector(hideAnimation), with: nil, afterDelay: TimeInterval(duration))
    }
    func showFromTopOffset(top: CGFloat) {
        let window: UIWindow = UIApplication.shared.windows.last!
        contentView.center = CGPoint(x: window.center.x, y: top + contentView.frame.size.height/2)
        window.addSubview(contentView)
        self.showAnimation()
        self.perform(#selector(hideAnimation), with: nil, afterDelay: TimeInterval(duration))
    }
    func showFromBottomOffset(bottom: CGFloat) {
        let window: UIWindow = UIApplication.shared.windows.last!
        contentView.center = CGPoint(x: window.center.x, y: window.frame.size.height - (bottom + contentView.frame.size.height/2))
        window.addSubview(contentView)
        self.showAnimation()
        self.perform(#selector(hideAnimation), with: nil, afterDelay: TimeInterval(duration))
    }
    // MARK: 中间显示
    class func showCenterWithText(text: String) {
        EWToast.showCenterWithText(text: text, duration: CGFloat(toastDispalyDuration))
    }
    class func showCenterWithText(text: String, duration: CGFloat) {
        let toast: EWToast = EWToast(text: text)
        toast.setDuration(duration: duration)
        toast.show()
    }
    // MARK: 上方显示
    class func showTopWithText(text: String) {
        EWToast.showTopWithText(text: text, topOffset: 100.0, duration: toastDispalyDuration)
    }
    class func showTopWithText(text: String, duration: CGFloat) {
        EWToast.showTopWithText(text: text, topOffset: 100, duration: duration)
    }
    class func showTopWithText(text: String, topOffset: CGFloat) {
        EWToast.showTopWithText(text: text, topOffset: topOffset, duration: toastDispalyDuration)
    }
    class func showTopWithText(text: String, topOffset: CGFloat, duration: CGFloat) {
        let toast = EWToast(text: text)
        toast.setDuration(duration: duration)
        toast.showFromTopOffset(top: topOffset)
    }
    // MARK: 下方显示
    class func showBottomWithText(text: String) {
        EWToast.showBottomWithText(text: text, bottomOffset: 100.0, duration: toastDispalyDuration)
    }
    class func showBottomWithText(text: String, duration: CGFloat) {
        EWToast.showBottomWithText(text: text, bottomOffset: 100.0, duration: duration)
    }
    class func showBottomWithText(text: String, bottomOffset: CGFloat) {
        EWToast.showBottomWithText(text: text, bottomOffset: bottomOffset, duration: toastDispalyDuration)
    }
    class func showBottomWithText(text: String, bottomOffset: CGFloat, duration: CGFloat) {
        let toast = EWToast(text: text)
        toast.setDuration(duration: duration)
        toast.showFromBottomOffset(bottom: bottomOffset)
    }
}

fileprivate class TextToast:NSObject{
    let view:UIView

    var toastLabel:UILabel
    var isToggled = false
    var duration:Float
 
    init(view:UIView, duration:Float = 1.0, positionFactor:(x: CGFloat, y: CGFloat) = (x:0.5,y:0.5)){
        self.view = view
        toastLabel = UILabel(frame: CGRect(x: view.frame.size.width * positionFactor.x - 75, y: view.frame.size.height * positionFactor.y - 35, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = ""
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.duration = duration
    }
    
    private func toggleToast() {
        if isToggled{
            toastLabel.removeFromSuperview()
        }else{
            view.addSubview(toastLabel)
        }
        isToggled = !isToggled
    }
    
    func hangUpToast(_ message:String){
        toastLabel.text = message
        view.addSubview(toastLabel)
        isToggled = true
    }
    
    func removeToast(){
        toastLabel.removeFromSuperview()
        isToggled = false
    }
    
    func showToast(_ message : String, duration:Double = 1.0, positionFactor:(x: CGFloat, y: CGFloat) = (x:0.5,y:0.5)) {
        
        toastLabel.frame = CGRect(x: view.frame.size.width * positionFactor.x - 75, y: view.frame.size.height * positionFactor.y - 35, width: 150, height: 35)
        
        toastLabel.text = message
        toggleToast()
        UIView.animate(withDuration: TimeInterval(duration), delay:TimeInterval(0.3*duration), options: .curveEaseOut, animations: {
            self.toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            self.toggleToast()
            self.toastLabel.alpha = 1.0
        })
    }
}


fileprivate class SpeakToast:NSObject{
    let view:UIView
    let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    init(view:UIView) {
        self.view = view
    }
    
//    var isReadyToCancel:Bool?{
//        willSet{
//            // 如果值未改变，不采取任何操作
//            if newValue == self.isReadyToCancel{
//                return
//            }
//
//            // 清空vibrance
//            for view in blurView.contentView.subviews{
//                view.removeFromSuperview()
//            }
//
//            if newValue == true{
//                //将动画添加到vibrancy视图中
//                let voiceImageView =  UIImageView(frame: CGRect(origin: CGPoint(x: 25, y: 3), size: CGSize(width: 150, height: 148)))
//
//                voiceImageView.image = coloredImage(image: UIImage(named: "MicrophoneReturn")!, red: 1, green: 1, blue: 1, alpha: 1)
//
//
//                let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height)))
//                label.text = "松开手指，取消发送"
//                label.textAlignment = .center
//                label.textColor = .white
//
//                // 清空vibrancy
//                for _view in blurView.contentView.subviews{
//                    _view.removeFromSuperview()
//                }
//
//                blurView.contentView.addSubview(voiceImageView)
//                blurView.contentView.addSubview(label)
//
//                label.snp.makeConstraints{
//                    make in
//                    //                    make.top.equalTo(imageView.snp.bottom).offset(10)
//                    make.centerX.equalTo(voiceImageView.snp.centerX)
//                    make.centerY.equalTo(voiceImageView.snp.centerY).offset(100)
//                }
//
//            }else{
//                //将动画添加到vibrancy视图中
//                let voiceImageView =  UIImageView(frame: CGRect(origin: CGPoint(x: 25, y: 3), size: CGSize(width: 150, height: 148)))
//                let gif = UIImage.gif(asset: "MicrophoneEnergy")
//                voiceImageView.image = coloredImage(image: (gif?.images?[0])!, red: 1, green: 1, blue: 1, alpha: 1)
//                voiceImageView.animationImages = gif?.images?.map({ (img) -> UIImage in
//                    return coloredImage(image: img, red: 1, green: 1, blue: 1, alpha: 1)
//                })
//
//
//                let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height)))
//                label.text = "手指上滑，取消发送"
//                label.textAlignment = .center
//                label.textColor = .white
//
//                // 清空vibrancy
//                for _view in blurView.contentView.subviews{
//                    _view.removeFromSuperview()
//                }
//
//                blurView.contentView.addSubview(voiceImageView)
//                blurView.contentView.addSubview(label)
//
//                label.snp.makeConstraints{
//                    make in
//                    make.centerX.equalTo(voiceImageView.snp.centerX)
//                    make.centerY.equalTo(voiceImageView.snp.centerY).offset(100)
//                }
//
//                // 开始播放动画
//                voiceImageView.animationDuration = 1
//                voiceImageView.animationRepeatCount = 10000
//                voiceImageView.startAnimating()
//            }
//        }
//    }
    
    var isPicAlertToggled = false{
        willSet{
            if newValue == self.isPicAlertToggled{
                return
            }
            
            if newValue == false{
                //self.isReadyToCancel = nil
                blurView.removeFromSuperview()
            }else{
                //设置模糊视图的大小
                blurView.frame = CGRect(x: view.frame.size.width * 0.5 - 100, y: view.frame.size.height * 0.5 - 100, width: 200, height: 200)
                
                blurView.layer.cornerRadius = 15
                blurView.layer.masksToBounds = true
                

                self.view.addSubview(blurView)
            }
        }
    }
}



//class ActivityViewController: UIViewController {
//
//    private let activityView = ActivityView()
//
//    init(message: String) {
//        super.init(nibName: nil, bundle: nil)
//        modalTransitionStyle = .crossDissolve
//        modalPresentationStyle = .overFullScreen
//        activityView.messageLabel.text = message
//        view = activityView
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class WaitingView: UIView {
    static let shared = WaitingView(message: "请稍后")
    let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    let boundingBoxView = UIView(frame: .zero)
    let messageLabel = UILabel(frame: .zero)

    init(message:String) {
        super.init(frame: .zero)

        backgroundColor = UIColor(white: 0.0, alpha: 0.0)

        boundingBoxView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        boundingBoxView.layer.cornerRadius = 12.0

        activityIndicatorView.startAnimating()

        messageLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.shadowColor = UIColor.black
        messageLabel.shadowOffset = CGSize(width: 0.0, height: 1.0)
        messageLabel.numberOfLines = 0

        addSubview(boundingBoxView)
        addSubview(activityIndicatorView)
        addSubview(messageLabel)
        
        messageLabel.text = message
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        boundingBoxView.frame.size.width = 160.0
        boundingBoxView.frame.size.height = 160.0
        boundingBoxView.frame.origin.x = ceil((bounds.width / 2.0) - (boundingBoxView.frame.width / 2.0))
        boundingBoxView.frame.origin.y = ceil((bounds.height / 2.0) - (boundingBoxView.frame.height / 2.0))

        activityIndicatorView.frame.origin.x = ceil((bounds.width / 2.0) - (activityIndicatorView.frame.width / 2.0))
        activityIndicatorView.frame.origin.y = ceil((bounds.height / 2.0) - (activityIndicatorView.frame.height / 2.0))

        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width: 160.0 - 20.0 * 2.0, height: CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size.width = messageLabelSize.width
        messageLabel.frame.size.height = messageLabelSize.height
        messageLabel.frame.origin.x = ceil((bounds.width / 2.0) - (messageLabel.frame.width / 2.0))
        messageLabel.frame.origin.y = ceil(activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + ((boundingBoxView.frame.height - activityIndicatorView.frame.height) / 4.0) - (messageLabel.frame.height / 2.0))
    }
}

func presentWait(message:String?,maxDuration:Float?,frame: CGRect?)-> WaitingView{
    let window = UIApplication.shared.windows.last!
    let theFrame:CGRect = frame ?? window.bounds
    let theMessage:String = message ?? "请稍后"
    let theMaxDuration = maxDuration ?? 15.0
    
    let waittingView = WaitingView.shared
    waittingView.messageLabel.text = theMessage
    waittingView.frame = theFrame
    
    window.addSubview(waittingView)
    DispatchQueue.main.asyncAfter(deadline: .now() + .init(theMaxDuration)) {
        waittingView.removeFromSuperview()
    }
    
    return waittingView
}
