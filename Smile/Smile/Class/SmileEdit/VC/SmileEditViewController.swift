//
//  SmileEditViewController.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import Alamofire

class SmileEditViewController: SSBaseViewController {

    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            self.dismiss(animated: true, completion: nil)
        }
    }
    var chooseFaceView:ChooseFaceView = {
        let v = ChooseFaceView.init(frame: .zero)
        v.contentMode = .scaleToFill
        v.isUserInteractionEnabled = true
        return v
    }()
    
    var chooseSmileView:ChooseSmileView = {
        let v = ChooseSmileView.init(smiles: [])
        return v
    }()
    
    var toolView:ChooseFaceToolView = {
        let v = ChooseFaceToolView.init(btnStrs: ["SmallSmile", "BigSmile"])
        return v
    }()
    
    
    var image:UIImage?
    var cacheSmallSmileFace:[[UIImage]] = []
    var cacheBigSmileFace:[[UIImage]] = []
    var cacheSelectSmileFace:[Int] = []
    
    var faceIndex:Int = 0
    var toolIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initView()
        
        self.showLoadingView()
        self.chooseFaceView.detectFace(success: { () -> Void? in
            self.initData()
        }) { () -> Void? in
            self.hindLoadingView()
        }
    }
    
    private func initData(){
        self.hindLoadingView()
        let count = self.chooseFaceView.faceRects.count
        for _ in 0...count{
            self.cacheBigSmileFace.append([])
            self.cacheSmallSmileFace.append([])
        };
    }
    
    private func initView(){
        self.view.backgroundColor = .white
        self.view.addSubview(chooseFaceView)
        self.view.addSubview(toolView)
        chooseFaceView.snp.makeConstraints { (make) in
            make.width.height.equalTo(SCREEN_WIDTH)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
        }
        
        self.view.addSubview(chooseSmileView)
        
        
        toolView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        
        chooseSmileView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.toolView.snp.top)
            make.height.equalTo(100)
        }
        
        toolView.delegate = self
        chooseFaceView.delegate = self
        chooseSmileView.delegate = self
        
        let nextItem:UIBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(clickSaveBtn))
        self.navigationItem.setRightBarButton(nextItem, animated: true)
    }
    
    init(image:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
        self.chooseFaceView.image = self.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickSaveBtn(){
        self.chooseFaceView.hiddenFaceRect()
        let image = self.chooseFaceView.asImage()
        let vc = FinishViewController.init(image: image, oriImage: self.image!)
        self.chooseFaceView.showFaceRect()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SmileEditViewController:ChooseFaceViewDelegate{
    func clickChooseFaceView(_ view: UIView, _ index: Int) {
        faceIndex = index
        if self.cacheBigSmileFace[faceIndex].count == 0{
            // get data
            let parameters: Parameters = [
                "image_key": self.chooseFaceView.getFaceAt(index: faceIndex).pngData()?.base64EncodedString() ?? ""
            ]

            self.showLoadingView()
            Alamofire.request("http://18.220.62.147:5000/api", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Content-Type" : "application/json"]).responseJSON { (data) in
                if let output = data.result.value as? NSDictionary{
                    if output["status_code"] as? Int == 0{
                        let bigSmile:[String] = output["big_smile"] as? [String] ?? []
                        let smallSmile = output["small_smile"] as? [String]
                        for base64Data in bigSmile{
                            let image = UIImage.init(data: Data(base64Encoded: base64Data, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
                            self.cacheBigSmileFace[index].append(image!)
                        }
                        
                        for base64Data in smallSmile ?? []{
                            let image = UIImage.init(data: Data(base64Encoded: base64Data, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
                            self.cacheSmallSmileFace[index].append(image!)
                        }
                        
                        
                        self.toolView.setClick(0)
                        
                    }else{
                        SSHintView.showHint(message: "Error! Try again!")
                    }
                }
                self.hindLoadingView()
            }
        }else{
            self.toolView.setClick(0)
        }
    }
}

extension SmileEditViewController:ChooseSmileViewDelegate{
    func clickChooseSmileView(_ image: UIImage, _ index: Int) {
        DispatchQueue.main.async {
            if self.toolIndex == 0{
                
                self.chooseFaceView.faceImageView[self.faceIndex].image = self.cacheSmallSmileFace[self.faceIndex][index]
            }else{
                self.chooseFaceView.faceImageView[self.faceIndex].image = self.cacheBigSmileFace[self.faceIndex][index]
            }
            
            self.clickSaveBtn()
            self.view.setNeedsDisplay()
        }
        
//        self.chooseFaceView.image = self.cacheBigSmileFace[self.faceIndex][index]
    }
}

extension SmileEditViewController:ChooseFaceToolViewDelegate{
    func clickChooseFaceToolAt(_ index: Int) {
        self.toolIndex = index
        
        if self.toolIndex == 0{
            self.chooseSmileView.setData(smiles: self.cacheSmallSmileFace[faceIndex], selectIdx: 0)
        }else{
            self.chooseSmileView.setData(smiles: self.cacheBigSmileFace[faceIndex], selectIdx: 0)
        }
        
    }
}

