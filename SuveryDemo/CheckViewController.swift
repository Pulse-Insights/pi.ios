//
//  CheckViewController.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/16.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class CheckViewController: BaseViewController, UITextFieldDelegate {
 
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var subtitle: UILabel! {
        didSet {
            container.setCustomSpacing(30, after: subtitle)
        }
    }
    @IBOutlet weak var idInput: UITextField! {
        didSet {
            idInput.layer.borderWidth = 1
            idInput.layer.borderColor = UIColor.black.cgColor
            idInput.layer.cornerRadius = 8
            idInput.layer.masksToBounds = true
            idInput.textColor = UIColor.black
            idInput.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var answerResultContainer: UIStackView!
    @IBOutlet weak var answerResultIcon: UIImageView!
    @IBOutlet weak var answerResultDesc: UILabel!
    @IBOutlet weak var resetResultDesc: UILabel!
    
    @IBAction func checkIfAnswered(_ sender: Any) {
        idInput.resignFirstResponder()
        let inputValue: String = idInput.text!
        let result = PulseInsights.getInstance.checkSurveyAnswered(inputValue)
        answerResultContainer.isHidden = false
        answerResultDesc.isHidden = false
        if(result) {
            answerResultIcon.isHidden = false
            answerResultDesc.text = "This survey has already been answered on this device, Please Reset Device UDID below."
        } else {
            answerResultIcon.isHidden = true
            answerResultDesc.text = "Survey has not been answered on this device. Please return to the Home page to trigger a survey."
        }
    }
    
    @IBAction func resetDeviceUDID(_ sender: Any) {
        PulseInsights.getInstance.resetUdid()
        idInput.resignFirstResponder()
        resetResultDesc.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inflateHelpButton()
        idInput.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idInput.resignFirstResponder()
        return true
    }
}

