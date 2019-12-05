//
//  XTPushSDKHelper.swift
//  XTPushSDK
//
//  Created by iMac-zk-dev on 2019/10/21.
//  Copyright © 2019 iMac-zk-dev. All rights reserved.
//
import Foundation
import FirebaseMessaging
import FirebaseInstanceID
let appSubTopic = "APPSUBTOPIC"
public let XTPushSDKHelperShared = XTPushSDKHelper()
@objc public class XTPushSDKHelper : NSObject {
    @objc  let pushTopic : UserDefaults = UserDefaults.standard
    @objc  var ptopic  = [String]()
    //MARK: --发送token给服务器
    @objc func sendFCMTokenToserver(){
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
    }
    //MARK: --发送topic订阅 默认发送10101订阅主题
    @objc public func sendSubscribe(Topic:String){
        
        Messaging.messaging().subscribe(toTopic: Topic) { error in
            if error != nil {
                print("Unable Subscribed to \(Topic) topic")
            }else{
                print("Subscribed to \(Topic) topic")
                self.pushDefaultTopic(tp: Topic)
        
            }
            
        }
    }
    
    
    //MARK: --存储订阅主题集合
    @objc  public  func pushDefaultTopic(tp:String){
        
        // pushTopic.set(tp, forKey: appSubTopic)
        if !ptopic.contains(tp){
            ptopic.append(tp)
            print("subTopic：\(tp)")
            print(self.ptopic)
        }
    }
    
    //MARK: --获取订阅主题集合
    @objc public func getTopic()->[String]{
        return ptopic
    }
    
    
    //MARK: --取消订阅主题/清空集合
    @objc public func cancelSubFromTopic(){
        for i in ptopic {
            Messaging.messaging().unsubscribe(fromTopic: i) { (error) in
                if error != nil {
                    print("-------remove fail \(i) , continue!--------")
                    Messaging.messaging().unsubscribe(fromTopic: i)
                }else{
                    print("--------remove \(i)!---------")
                }
            }
            if i == ptopic[ptopic.count - 1] {
                ptopic.removeAll()
                print("----------\(i) remove sucess!---------")
            }else{
                print("---------remove\(i)!-----------")
            }
        }
        
    }
    
}

