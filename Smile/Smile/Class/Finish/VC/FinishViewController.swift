//
//  FinishViewController.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import SCSDKCreativeKit

class FinishViewController: SSBaseViewController {
    var chooseFaceView:ChooseFaceView = {
    let v = ChooseFaceView.init(frame: .zero)
        v.contentMode = .scaleToFill
        return v
    }()
    
    var image:UIImage?
    var oriImage:UIImage?
    var saveBtn:UIButton = UIButton.init(frame: .zero)
    var shareBtn:UIButton = UIButton.init(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    private func initView(){
        
        let nextItem:UIBarButtonItem = UIBarButtonItem.init(title: "Finish", style: .plain, target: self, action: #selector(clickFinishBtn))
        self.navigationItem.setRightBarButton(nextItem, animated: true)
        
        self.view.backgroundColor = .white
        self.view.addSubview(chooseFaceView)
        chooseFaceView.snp.makeConstraints { (make) in
            make.width.height.equalTo(SCREEN_WIDTH)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
        }
        
        self.view.addSubview(saveBtn)
        self.view.addSubview(shareBtn)
        shareBtn.isHidden = true
        saveBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(64)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        saveBtn.setImage(UIImage.init(named: "save_btn"), for: .normal)
        saveBtn.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
        saveBtn.imageView?.contentMode = .scaleAspectFit
        shareBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(64)
            make.bottom.equalTo(self.saveBtn.snp.top).offset(-20)
        }
        
        shareBtn.imageView?.contentMode = .scaleAspectFit
        shareBtn.setImage(UIImage.init(named: "share_btn"), for: .normal)
        shareBtn.addTarget(self, action: #selector(clickShareBtn), for: .touchUpInside)
    }
    
    @objc func clickFinishBtn(){
        let array = self.navigationController?.viewControllers
        for vc in array ?? []{
            if vc is ViewController{
                self.navigationController?.popToViewController(vc, animated: false)
                return
            }
        }
    }
    
    @objc func clickSaveBtn(){
        UIImageWriteToSavedPhotosAlbum(self.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func clickShareBtn(){
        let snapImage:UIImage = self.image!
        let photo = SCSDKSnapPhoto(image: snapImage)
//        SCSDKSnapContent
        let photoContent = SCSDKPhotoSnapContent(snapPhoto: photo)
        let api = SCSDKSnapAPI(content: photoContent)
        api.startSnapping { (error) in
//            SSHintView.showHint(message: "Share Error")
            debugPrint(error)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SSHintView.showHint(message: "Save Successful!")
            }
            
        }
    }
    
    init(image:UIImage, oriImage:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
        self.oriImage = oriImage
        self.chooseFaceView.image = self.image
        self.chooseFaceView.setEnableLongTap()
        self.chooseFaceView.originImage = image
        self.chooseFaceView.underImage = oriImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
