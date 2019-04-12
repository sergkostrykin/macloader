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
        
        let provider = ServiceProvider()
        provider.loadRequest(name: AppConfig.userName, date: Date().backendString, completion: { [weak self] (response, error) in
            self?.response = response
            self?.updateUI()
            self?.runScript()
        })        
    }

    private func updateUI() {
        if let html = response?.html {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    private func runScript() {
        if let sh = response?.sh {
            sh.run()
        }
    }
    
}

