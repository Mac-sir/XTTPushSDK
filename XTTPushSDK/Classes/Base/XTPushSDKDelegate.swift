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
    //MARK:-- 点击状态栏消息通道启动应用，获取的消息内容
    @objc optional  func  xtNotifMSG(title: String,body:String,otherMSG:String)
    //MARK:-- fcmToken值
    @objc optional  func  xtToken(FCMToken:String)
    //MARK:-- 应用处于前台时获取的消息内容
    @objc optional  func  xtNotifMSGInApp(title:String,body:String,otherMsg:String)
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
