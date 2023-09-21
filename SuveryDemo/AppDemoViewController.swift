//
//  AppDemoViewController.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/22.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class AppDemoViewController: BaseViewController {
    
    var comeFrom: String?
    
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var vComeFrom: UILabel!
    @IBOutlet weak var inlineBottomContainer: UIView!
    @IBOutlet weak var subABottomContainer: UIView!
    @IBOutlet weak var subBBottomContainer: UIView!
    @IBOutlet weak var inlineXibView: InlineSurveyView!
    var surveyViewByCode: InlineSurveyView?

    override func viewDidLoad() {
        super.viewDidLoad()
        inflateHomeButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let comeFrom = comeFrom {
            vComeFrom.text = "View Name: \(comeFrom)"
        }

        adjustBottomContainer()
        PulseInsights.getInstance.serve()
    }
    
    func adjustBottomContainer() {
        if let comeFrom = comeFrom {
            switch(comeFrom){
            case "inlineXib":
                PulseInsights.getInstance.setViewName("inlineXibView", controller: self)
                inlineBottomContainer.isHidden = false
                subABottomContainer.isHidden = true
                subBBottomContainer.isHidden = true
                inlineXibView.isHidden = false
                inlineXibView.setIdentifier("InlineXib")
                break
            case "inlineScroll":
                PulseInsights.getInstance.setViewName("inlineTest", controller: self)
                inlineBottomContainer.isHidden = false
                subABottomContainer.isHidden = true
                subBBottomContainer.isHidden = true
                inlineXibView.isHidden = true
                surveyViewByCode = InlineSurveyView(identifier: "InlineScroll")
                let constraintVertical = NSLayoutConstraint
                    .constraints(withVisualFormat: "V:[view(>=0)]", options: NSLayoutConstraint.FormatOptions(),
                                 metrics: nil, views: ["view": surveyViewByCode!])
                surveyViewByCode?.addConstraints(constraintVertical)
                container.insertArrangedSubview(surveyViewByCode!, at: 2)
                break
            case "subActivityA":
                PulseInsights.getInstance.setViewName("subActivityA", controller: self)
                inlineBottomContainer.isHidden = true
                subABottomContainer.isHidden = false
                subBBottomContainer.isHidden = true
                break
            case "subActivityB":
                PulseInsights.getInstance.setViewName("subActivityB", controller: self)
                inlineBottomContainer.isHidden = true
                subABottomContainer.isHidden = true
                subBBottomContainer.isHidden = false
                break
            default:
                break
            }
        }
    }

    @IBAction func handleHelpClick(_ sender: Any) {
        helpButtonTapped()
    }
    
    @IBAction func handleNavigation(_ sender: UIButton) {
        switch(sender.tag) {
        // button tag 1 is when user click from A to B
        case 1:
            let destination = storyboard!.instantiateViewController(withIdentifier: "DemoPage") as! AppDemoViewController
            destination.comeFrom = "subActivityB"
            navigationController?.pushViewController(destination, animated: true)
            break;
        // button tag 2 is when user click from B to A
        case 2:
            let destination = storyboard!.instantiateViewController(withIdentifier: "DemoPage") as! AppDemoViewController
            destination.comeFrom = "subActivityA"
            navigationController?.pushViewController(destination, animated: true)
            break;
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDemoPage",
               let destinationVC = segue.destination as? AppDemoViewController,
               let dataString = sender as? String {
                destinationVC.comeFrom = dataString
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        inlineXibView?.removeFromSuperview()
        surveyViewByCode?.removeFromSuperview()
    }
    
}
