//
//  InlineTestViewController.swift
//  PulseInsights
//
//  Created by LeoChao on 2018/3/1.
//  Copyright © 2018年 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class InlineTestViewController: BaseViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var clientKeyView: ClientKeyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inflateHelpButton()
        scrollView.delegate = self
        clientKeyView.clientKeyInput.delegate = self
    }
    
    @IBAction func triggerInlineXib(_ sender: Any) {
        performSegue(withIdentifier: "goDemoPage", sender: "inlineXib")
    }
    
    @IBAction func triggerInlineScroll(_ sender: Any) {
        performSegue(withIdentifier: "goDemoPage", sender: "inlineScroll")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDemoPage",
               let destinationVC = segue.destination as? AppDemoViewController,
               let dataString = sender as? String {
                destinationVC.comeFrom = dataString
            }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
