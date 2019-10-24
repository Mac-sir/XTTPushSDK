//
//  XTPushSDKDelegate.swift
//  XTPushSDK
//
//  Created by iMac-zk-dev on 2019/10/21.
//  Copyright © 2019 iMac-zk-dev. All rights reserved.
//

import Foundation
//MARK:-- 消息代理
@objc public protocol XTPushSDKDelegate:NSObjectProtocol {
    @objc optional  func  xtNotifMSG(title: String,body:String,otherMSG:String)
    @objc optional  func  xtToken(FCMToken:String)
}
//MARK:-- 代理对象
@objc public class XTPushMSG : NSObject {

    weak open var delegate: XTPushSDKDelegate?
    
    public class var XTPush :XTPushMSG {
    struct Static {
        static let initfcm = XTPushMSG()
    }
    return Static.initfcm
   }
}
