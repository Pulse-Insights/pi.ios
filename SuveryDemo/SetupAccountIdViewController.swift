//
//  SetupAccountIdViewController.swift
//  PulseInsights
//
//  Created by Chao Shih-Chuan on 2017/2/1.
//  Copyright © 2017年 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights
class SetupAccountIdViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fieldAccountId: UITextField! {
        didSet {
            fieldAccountId.layer.borderWidth = 1
            fieldAccountId.layer.borderColor = UIColor.black.cgColor
            fieldAccountId.layer.cornerRadius = 8
            fieldAccountId.layer.masksToBounds = true
            fieldAccountId.textColor = UIColor.black
            fieldAccountId.backgroundColor = UIColor.white
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 8.0
            saveButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        fieldAccountId.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let mTmpObjUrl = UserDefaults.standard.object(forKey: "ACCOUNT_ID")
        if let accountId: String
            = ( mTmpObjUrl != nil && mTmpObjUrl is String ) ? ( mTmpObjUrl as? String ) : "" {
            fieldAccountId.text = accountId
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fieldAccountId.resignFirstResponder()
        return true
    }

    @IBAction func tapped(_ sender: AnyObject) {
        let inputValue: String = fieldAccountId.text!
        UserDefaults.standard.set(inputValue, forKey: "ACCOUNT_ID")
        UserDefaults.standard.synchronize()
        fieldAccountId.resignFirstResponder()
        PulseInsights.getInstance.configAccountID(inputValue)
        let homePage = storyboard!.instantiateViewController(withIdentifier: "MainPage")
        navigationController?.pushViewController(homePage, animated: true)
    }
    
}
