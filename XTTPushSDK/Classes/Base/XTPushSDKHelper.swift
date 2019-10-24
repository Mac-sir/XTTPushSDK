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
            print("1Subscribed to \(Topic) topic")
            self.pushDefaultTopic(tp: Topic)
          }
              
          }
        }
    
    
    //MARK: --存储订阅主题
   @objc  public  func pushDefaultTopic(tp:String){
        print("订阅主题：\(tp)")
        pushTopic.set(tp, forKey: appSubTopic)
    }
    
    //MARK: --获取订阅主题
    @objc public func getTopic()->String{
        return pushTopic.string(forKey: appSubTopic) ?? ""
    }
    
    
    //MARK: --取消订阅主题
   @objc public func cancelSubFromTopic()->String{
        var result = ""
        if let topic = pushTopic.string(forKey: appSubTopic){
            Messaging.messaging().unsubscribe(fromTopic: topic) { (error) in
                if error != nil {
                   result = "Cancel-Success"
                }else{
                   result = "Cancel_Faile"
                }
            }
            return result
        }else{
            result = "Topic_isEmpty"
            return result
        }
    }
}

