//
//  ClientKeyView.swift
//  SuveryDemo
//
//  Created by long shen on 2023/8/18.
//  Copyright © 2023 Pulse Insights. All rights reserved.
//

import UIKit
import PulseInsights

class ClientKeyView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var clientKeyInput: UITextField! {
        didSet {
            clientKeyInput.layer.borderWidth = 1
            clientKeyInput.layer.borderColor = UIColor.black.cgColor
            clientKeyInput.layer.cornerRadius = 8
            clientKeyInput.layer.masksToBounds = true
            clientKeyInput.textColor = UIColor.black
            clientKeyInput.backgroundColor = UIColor.white
        }
    }
    
    @IBOutlet weak var actionResultDesc: UILabel!
    
    @IBAction func handleSaveClick(_ sender: Any) {
        let inputKey: String = clientKeyInput.text!
        PulseInsights.getInstance.setClientKey(inputKey)
        actionResultDesc.isHidden = false
        actionResultDesc.text = "Client key has been set. Please choose one of the survey triggers above."
    }
    
    
    @IBAction func handleClearClick(_ sender: Any) {
        PulseInsights.getInstance.setClientKey("")
        actionResultDesc.isHidden = false
        clientKeyInput.text = ""
        actionResultDesc.text = "Client key has been cleared."
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        loadViewFromNib()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
 }
