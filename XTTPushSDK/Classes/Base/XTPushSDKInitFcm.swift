//  XTPushSDKInitFcm.swift
//  XTPushSDK
//
//  Created by iMac-zk-dev on 2019/10/21.
//  Copyright © 2019 iMac-zk-dev. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseMessaging
import UserNotifications
//MARK: --须在appdelegate中初始化 XTPushSDKInitFcm.shared.shareInstance()
@objc public class XTPushSDKInitFcm: NSObject{
    
    @objc let gcmMessageIDKey = "gcm.message_id"
    //MARK: -- 初始化
    @objc public func shareInstance(){
        initFcm()
    }
    @objc func initFcm(){
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        XTPushSDKHelperShared.sendFCMTokenToserver()//跟apns进行绑定
    }
    
    
    //MARK: -- 实例化对象
    @objc public class var shared : XTPushSDKInitFcm {
        struct Static {
            static let initfcm = XTPushSDKInitFcm()
        }
        return Static.initfcm
    }
    
}
//MARK: -- 代理获取token值
extension XTPushSDKInitFcm : MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let dataDict:[String: String] = ["token": fcmToken]
        if let FCMTOKEN = dataDict["token"] {
print("--------------------------------------------------------------------------------------------------------------------\n")
print("fcmtoken:\(FCMTOKEN)                                                             \n")
print("--------------------------------------------------------------------------------------------------------------------\n")
            if XTPushMSG.XTPush.delegate != nil && XTPushMSG.XTPush.delegate!.responds(to: #selector(XTPushSDKDelegate.xtToken(FCMToken:))){
                XTPushMSG.XTPush.delegate?.xtToken?(FCMToken: FCMTOKEN)//回传token
            }
        }
    }
    
}
//MARK: -- 代理获取消息内容
@available(iOS 10, *)
extension XTPushSDKInitFcm: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("-----XTTPushSDK-----\n MessageID(1): \(messageID)")
        }
        let userInfoBody = response.notification.request.content.body
        let userInfoTitle = response.notification.request.content.title
        var userOtherMsg = ""
        if let aps = userInfo["aps"] as? NSDictionary {
            if let msg = aps["msg"] as? NSString {
                userOtherMsg = msg as String
            }
        }
        print("-----XTTPushSDK-----\n userInfoTitle:\(userInfoTitle) userInfoBody:\(userInfoBody) userOtherMsg:\(userOtherMsg)")
        if XTPushMSG.XTPush.delegate != nil && (XTPushMSG.XTPush.delegate?.responds(to: #selector(XTPushSDKDelegate.xtNotifMSG(title:body:otherMSG:))))!{
            XTPushMSG.XTPush.delegate?.xtNotifMSG?(title: userInfoTitle, body: userInfoBody, otherMSG: userOtherMsg)
        }
        completionHandler()
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("-----XTTPushSDK-----\n MessageID(2): \(messageID)")
        }
        let userInfoBody = notification.request.content.body
        let userInfoTitle = notification.request.content.title
        var userOtherMsg = ""
        if let aps = userInfo["aps"] as? NSDictionary {
            if let msg = aps["msg"] as? NSString {
                userOtherMsg = msg as String
            }
        }
        print("-----XTTPushSDK-----\n userInfoTitle:\(userInfoTitle) userInfoBody:\(userInfoBody) userOtherMsg:\(userOtherMsg)")
        if XTPushMSG.XTPush.delegate != nil && (XTPushMSG.XTPush.delegate?.responds(to: #selector(XTPushSDKDelegate.xtNotifMSGInApp(title:body:otherMsg:))))!{
            XTPushMSG.XTPush.delegate?.xtNotifMSGInApp?(title: userInfoTitle, body: userInfoBody, otherMsg: userOtherMsg)
        }
        completionHandler([])
    }
    
    
}
