//
//  ViewController.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import YPImagePicker
import Alamofire

class ViewController: UIViewController {
    var isCreateNewFace:Bool = false
    
    var datas:[SSItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            var config = YPImagePickerConfiguration()
            config.screens = [.library, .photo]
            
            // photo
            config.library.maxNumberOfItems = 1
            config.library.minNumberOfItems = 1
            
            
            let picker = YPImagePicker(configuration: config)
            
            
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    print(photo.fromCamera) // Image source (camera or library)
                    print(photo.image) // Final image selected by the user
                    print(photo.originalImage) // original image selected by the user, unfiltered
                    print(photo.modifiedImage) // Transformed image, can be nil
                    print(photo.exifMeta) // Print exif meta data of original image.
                    
                    picker.dismiss(animated: true, completion: {
                        let vc = SmileEditViewController.init(image: photo.image)
                        //                    let vc = FinishViewController(image: photo.image, oriImage: UIImage.init(named: "share_btn")!)
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                    
                    
                }
                picker.dismiss(animated: true, completion: {
                    
                })
            }
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.becomeFirstResponder()
        if !isCreateNewFace{
            return
        }
        
        isCreateNewFace = false
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        
        // photo
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        
        
        let picker = YPImagePicker(configuration: config)
        
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                picker.dismiss(animated: true, completion: {
                    let vc = SmileEditViewController.init(image: photo.image)
//                    let vc = FinishViewController(image: photo.image, oriImage: UIImage.init(named: "share_btn")!)
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                
                
            }
            picker.dismiss(animated: true, completion: {
                
            })
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func initViews(){
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(frame: .zero)
    }
    
    
}

