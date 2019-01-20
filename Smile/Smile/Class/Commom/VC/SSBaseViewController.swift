//
//  SSBaseViewController.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

class SSBaseViewController: UIViewController {
    fileprivate weak var _loadView:SSLoadingView?
    func showLoadingView() {
        self.hindLoadingView()
        let aloadView = SSLoadingView()
        aloadView.backgroundColor = RGBA(122, 122, 122, 122)
        self.view.addSubview(aloadView)
        aloadView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        self._loadView = aloadView
    }
    
    func hindLoadingView() {
        self._loadView?.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
