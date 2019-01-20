//
//  ChooseFaveView.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import Vision
import Popover

public protocol ChooseFaceViewDelegate:class{
    func clickChooseFaceView(_ view:UIView, _ index:Int)
}

class ChooseFaceView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var faceRects: [FaceRectView] = []
    var selectRect: FaceRectView?
    var delegate:ChooseFaceViewDelegate?
    var faceImageView:[UIImageView] = []
    
    var isEnableLongTap:Bool = false
    var underImage:UIImage?
    var originImage:UIImage?
    
    
    private var _didFinishPicking: ((UIImage, Bool) -> Void)?
    public func didFinishPicking(completion: @escaping (_ items: UIImage, _ cancelled: Bool) -> Void) {
        _didFinishPicking = completion
    }
    
    
    public func getFaceAt(index:Int) -> UIImage{
        return self.image?.cropImage(toRect: faceRects[index].frame, viewWidth: self.frame.size.width, viewHeight: self.frame.size.height) ?? UIImage.init()
    }
    
    
    public func detectFace(success:@escaping ()->Void?, fail:@escaping ()->Void?) -> Void {
        guard let cgImage = CIImage(image: self.image!) else {
            fail()
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: cgImage, options: [:])
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            DispatchQueue.main.async {
                if let result = request.results{
                    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.frame.size.height)
                    let translate = CGAffineTransform.identity.scaledBy(x: self.frame.size.width, y: self.frame.size.height )
                    
                    for item in result{
                        let faceRect = FaceRectView(frame: CGRect.zero)
                        let imageView = UIImageView.init(frame: .zero)
                        faceRect.didTapView {
                            if (self.selectRect != faceRect && self.selectRect != nil){
                                self.selectRect?.setUnSelect()
                            }
                            self.selectRect = faceRect
                            var idx = 0
                            for rect in self.faceRects{
                                if rect == faceRect{
                                    break
                                }
                                idx = idx + 1
                            }
                            
                            self.delegate?.clickChooseFaceView(faceRect, idx)
                        }
                        
                        self.faceImageView.append(imageView)
                        self.faceRects.append(faceRect)
                        self.addSubview(imageView)
                        self.addSubview(faceRect)
                        
                        
                        if let faceObservation = item as? VNFaceObservation{
                            print(faceObservation.boundingBox)
                            var finalRect = faceObservation.boundingBox.applying(translate).applying(transform)
//                            finalRectfinalRect.applying(CGAffineTransform(scaleX: 2, y: 2))
                            finalRect = CGRect.init(x: finalRect.origin.x - finalRect.size.width * 0.1, y: finalRect.origin.y - finalRect.size.height * 0.1, width: finalRect.size.width * 1.2 , height: finalRect.size.height * 1.2)
                            finalRect = finalRect.intersection(self.bounds)
                            
                            imageView.image = self.image?.cropImage(toRect: finalRect, viewWidth: self.frame.size.width, viewHeight: self.frame.size.height)
                            imageView.frame = finalRect
                            faceRect.frame = finalRect
                        }
                    }
                }
                success()
            }
        }
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try handler.perform([request])
            }catch{
                fail()
            }
        }
        
        
    }
    
    public func setEnableLongTap(){
        self.isEnableLongTap = true
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer.init(target: self, action: #selector(longTapGesture(_:))))
        
    }
    
    
    public func hiddenFaceRect(){
        for view in self.faceRects {
            view.removeFromSuperview()
        }
    }
    
    public func showFaceRect(){
        for view in self.faceRects {
            self.addSubview(view) 
        }
    }
    
    @objc func longTapGesture(_ re:UILongPressGestureRecognizer){
        if isEnableLongTap{
            if re.state == .began{
                self.image = underImage
            }else if re.state == .ended ||  re.state == .failed || re.state == .cancelled {
                self.image = originImage
            }
        }
        
    }
}
