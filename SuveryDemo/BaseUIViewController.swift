//
//  BaseUIViewController.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/22.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//
import UIKit
import PulseInsights

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func inflateHelpButton() {
        let helpButton = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(helpButtonTapped))
        navigationItem.rightBarButtonItem = helpButton
    }
    
    @objc func helpButtonTapped() {
        performSegue(withIdentifier: "goHelpPage", sender: nil)
    }
    
    func inflateHomeButton() {
        let homeButton = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: self, action: #selector(homeButtonTapped))
        navigationItem.rightBarButtonItem = homeButton
    }
    
    @objc func homeButtonTapped() {
        if let viewControllers = navigationController?.viewControllers {
            for controller in viewControllers {
                if let mainVC = controller as? MainViewController {
                    navigationController?.popToViewController(mainVC, animated: true)
                    break
                }
            }
        }
    }
}
