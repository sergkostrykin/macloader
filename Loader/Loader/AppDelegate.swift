//
//  AppDelegate.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setup()
        NSApplication.shared.servicesProvider = ServiceProvider()
        NSUpdateDynamicServices()
    }

}



extension AppDelegate {
    
    func setup() {
        if Double.readFromFile(with: AppConfig.resendIntervalKey) == nil {
            AppConfig.resendInterval.writeToFile(for: AppConfig.resendIntervalKey)
        }
    }
}

