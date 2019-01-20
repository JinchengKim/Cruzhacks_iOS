//
//  SSItem.swift
//  Smile
//
//  Created by 李金 on 1/19/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit
import RealmSwift

class SSItem: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var imageData:Data?
}
