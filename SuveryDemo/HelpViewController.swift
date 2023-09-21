//
//  File.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/17.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: BaseViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://docs.pulseinsights.com/configuring-pulse-insights-console/editor/demo-app-help") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
