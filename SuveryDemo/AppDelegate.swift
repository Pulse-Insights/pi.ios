//
//  AppDelegate.swift
//  SuveryDemo
//
//  Created by Chao Shih-Chuan on 2016/12/14.
//  Copyright © 2016年 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mPI: PulseInsights?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let piAccountId = UserDefaults.standard.object(forKey: "ACCOUNT_ID")
        if let accountId: String = ( piAccountId != nil && piAccountId is String )
            ? ( piAccountId as? String ) : "" {
                mPI = PulseInsights(accountId, enableDebugMode: true, customData: ["name": "tester_ios", "type": "worker", "age": "12"])
            #if STAGING
                mPI?.setHost("staging-survey.pulseinsights.com")
            #else
                mPI?.setHost("survey.pulseinsights.com")
            #endif
        }
        return true
    }
}
