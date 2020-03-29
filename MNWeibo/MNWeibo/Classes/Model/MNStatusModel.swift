//
//  MNStatusModel.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit
import YYModel

class MNStatusModel: NSObject {
    @objc var id: Int64 = 0
    
    @objc var text: String?
    
    @objc var user: MNUserModel?
    
    @objc var reposts_count = 0
    
    @objc var comments_count = 0
    //点赞数
    @objc var attitudes_count = 0
    
    @objc var pic_urls: [MNStatusPicture]?
    
    //被转发微博
    @objc var retweeted_status: MNStatusModel?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    @objc class func modelContainerPropertyGenericClass() -> [String:AnyClass]{
        return ["pic_urls":MNStatusPicture.self]
    }
}
