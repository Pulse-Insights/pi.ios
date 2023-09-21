//
//  OtherTestSurveyViewController.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/22.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class OtherTestSurveyViewController: BaseViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var clientKeyView: ClientKeyView!
    override func viewDidLoad() {
        super.viewDidLoad()
        inflateHelpButton()
        scrollView.delegate = self
        clientKeyView.clientKeyInput.delegate = self
    }
    
    @IBAction func triggerSurvey(_ sender: Any) {
        PulseInsights.getInstance.setViewName("mainActivity", controller: self)
        PulseInsights.getInstance.serve()
    }
    
    @IBAction func triggerSubASurvey(_ sender: Any) {
        performSegue(withIdentifier: "goDemoPage", sender: "subActivityA")
    }
    
    
    @IBAction func triggerSubBSurvey(_ sender: Any) {
        performSegue(withIdentifier: "goDemoPage", sender: "subActivityB")
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
