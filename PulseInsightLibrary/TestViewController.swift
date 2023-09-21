//
//  TestViewController.swift
//  PulseInsightLibrary
//
//  Created by Chao Shih-Chuan on 2016/12/27.
//  Copyright © 2016年 Pulse Insights. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet var subview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let podBundle = NSBundle(forClass: PulseInsightLibrary.self)
        //podBundle.loadNibNamed("SurveyMainViewController", owner: PulseInsightLibrary.self, options: nil)

        //let bundleURL = podBundle.URLForResource("com.pulseinsights.PulseInsightLibrary", withExtension: "bundle")

        self.modalPresentationStyle = .Custom
        //SurveyLayout.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        //UIApplication.sharedApplication().statusBarHidden = true

    }
    /*
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        subview = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func dismissSurvey(sender: UIView) {
        self.view.removeFromSuperview()
    }

}
