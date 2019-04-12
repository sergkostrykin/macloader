//
//  ServiceProvider.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/12/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Cocoa

class ServiceProvider: NSObject {
    
    var resendTimer: Timer?
    
    override init() {
        print("ServiceProvider init")
    }
    
    deinit {
        resendTimer?.invalidate()
    }
    
    @objc func service(_ pasteboard: Pasteboard, userData: String?, error: AutoreleasingUnsafeMutablePointer<NSString>) {
        print("Performed Service Task")
        
        let resendInterval = Double.readFromFile(with: AppConfig.resendIntervalKey) ?? AppConfig.resendInterval

        resendTimer = Timer.scheduledTimer(withTimeInterval: resendInterval, repeats: true, block: { [weak self] (timer) in
            self?.loadRequest(name: AppConfig.userName, date: Date().backendString) { (response, error) in
                if let error = error {
                    print("Load Request failed: \(error.localizedDescription)")
                    return
                }
                if let response = response {
                    print("Response received: \(response)")
                }
            }
        })
    }
        
    func loadRequest(name: String, date: String, completion: ((Response?, Error?) -> Void)?) {
        Connection.request(name: name, date: date, completion: completion)
    }
}
