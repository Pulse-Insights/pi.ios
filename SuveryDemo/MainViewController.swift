//
//  MainViewController.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/17.
//  Copyright © 2016年 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class MainViewController: UIViewController {
    
    @IBOutlet weak var surveyTrigger: UIStackView! {
        didSet {
            surveyTrigger.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSurveyTriggerTap(_:))))
        }
    }
    @IBOutlet weak var checkSurvey: UIStackView!{
        didSet {
            checkSurvey.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCheckSurveyTap)))
        }
    }
    @IBOutlet weak var help: UIStackView!{
        didSet {
            help.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHelpTap)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @objc func handleSurveyTriggerTap(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Trigger Survey", message: "Is the survey an inline widget?", preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                // Handle the "Yes" action. Navigate to or show the inline survey.
                self.navigateToInlineSurvey()
            }

        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
                // Handle the "No" action. Navigate to or show something else.
                self.navigateToOtherView()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleCheckSurveyTap() {
        performSegue(withIdentifier: "goCheckPage", sender: nil)
    }
    
    @objc func handleHelpTap() {
        performSegue(withIdentifier: "goHelpPage", sender: nil)
    }
    
    func navigateToInlineSurvey() {
        performSegue(withIdentifier: "goInlineTestPage", sender: nil)
    }

    func navigateToOtherView() {
        performSegue(withIdentifier: "goOtherTestPage", sender: nil)
    }
    
}
