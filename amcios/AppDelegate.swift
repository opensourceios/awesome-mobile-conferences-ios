//
//  AppDelegate.swift
//  amcios
//
//  Created by Matteo Crippa on 9/25/17.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import OneSignal
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // setup push notification
    setupPush(launchOptions)
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}

  func applicationDidEnterBackground(_ application: UIApplication) {}

  func applicationWillEnterForeground(_ application: UIApplication) {}

  func applicationDidBecomeActive(_ application: UIApplication) {}

  func applicationWillTerminate(_ application: UIApplication) {}

}

extension AppDelegate {
    func setupPush(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]

        // WARN: Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "YOUR_APP_ID",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)

        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification

        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
}
