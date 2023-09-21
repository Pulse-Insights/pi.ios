//
//  WidgetView.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/05/14.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

class WidgetView: UIView {
//    @IBOutlet weak var testSurvey: SurveyView!
    @IBOutlet weak var outContainer: UIView! {
        didSet {
            outContainer.layer.backgroundColor = LocalConfig.instance.themeStyle.widget.backgroundColor.color.cgColor
            outContainer.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.widget.borderWidth)
            outContainer.layer.borderColor = LocalConfig.instance.themeStyle.widget.borderColor.color.cgColor
        }
    }
    @IBOutlet weak var mainPaddingRight: NSLayoutConstraint! {
        didSet {
            let mainPadding = LocalConfig.instance.themeStyle.widget.padding
            mainPaddingRight.constant = CGFloat(mainPadding)
        }
    }
    @IBOutlet weak var mainPaddingLeft: NSLayoutConstraint! {
        didSet {
            let mainPadding = LocalConfig.instance.themeStyle.widget.padding
            mainPaddingLeft.constant = CGFloat(mainPadding)
        }
    }
    @IBOutlet weak var mainPaddingTop: NSLayoutConstraint! {
        didSet {
            let mainPadding = LocalConfig.instance.themeStyle.widget.padding
            mainPaddingTop.constant = CGFloat(mainPadding)
        }
    }
    @IBOutlet weak var mainPaddingBottom: NSLayoutConstraint! {
        didSet {
            let mainPadding = LocalConfig.instance.themeStyle.widget.padding
            mainPaddingBottom.constant = CGFloat(mainPadding)
        }
    }
    @IBOutlet weak var piWidgetMainbody: UIView! {
        didSet {
            piWidgetMainbody.layer.backgroundColor = UIColor.clear.cgColor
            piWidgetMainbody.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBOutlet weak var piWidgetClose: UIView! {
        didSet {
            piWidgetClose.layer.backgroundColor = UIColor.clear.cgColor
            piWidgetClose.isHidden = !LocalConfig.instance.themeStyle.closeBtn.display
        }
    }
    @IBOutlet weak var invitationLabel: PaddingLabel! {
        didSet {
            LocalConfig.instance.themeStyle.invite.applyMargin(labelView: invitationLabel)
        }
    }
    @IBOutlet weak var styledImage: StyledImageView! {
        didSet {
            styledImage.imageStyle = LocalConfig.instance.themeStyle.surveyImg
        }
    }
    @IBOutlet weak var closeLabel: UILabel! {
        didSet {
            closeLabel.text = "\u{2715}"
            closeLabel.textColor = LocalConfig.instance.themeStyle.closeBtn.fontColor.color
        }
    }
    @IBOutlet weak var closeMarginRight: NSLayoutConstraint! {
        didSet {
            let assignMargin = LocalConfig.instance.themeStyle.closeBtn.margin
            if assignMargin >= 0 {
                closeMarginRight.constant = CGFloat(assignMargin)
            }
        }
    }
    @IBOutlet weak var closeMarginTop: NSLayoutConstraint! {
        didSet {
            let assignMargin = LocalConfig.instance.themeStyle.closeBtn.margin
            if assignMargin >= 0 {
                closeMarginTop.constant = CGFloat(assignMargin)
            }
        }
    }
    @IBOutlet weak var closeMarginBottom: NSLayoutConstraint! {
        didSet {
            let assignMargin = LocalConfig.instance.themeStyle.closeBtn.margin
            if assignMargin >= 0 {
                closeMarginBottom.constant = CGFloat(assignMargin)
            }
        }
    }
    @IBOutlet weak var closeMarginLeft: NSLayoutConstraint! {
        didSet {
            let assignMargin = LocalConfig.instance.themeStyle.closeBtn.margin
            if assignMargin >= 0 {
                closeMarginLeft.constant = CGFloat(assignMargin)
            }
        }
    }

    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var btnMarginTop: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginTop)
        }
    }
    @IBOutlet weak var btnMarginRight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginRight)
        }
    }

    @IBOutlet weak var btnMarginLeft: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginLeft)
        }
    }

    @IBOutlet weak var btnMarginBottom: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configMarginConstraint(btnMarginBottom)
        }
    }

    @IBOutlet weak var startBtnWidth: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configWidthConstraint(startBtnWidth)
        }
    }
    @IBOutlet weak var startBtnHeight: NSLayoutConstraint! {
        didSet {
            LocalConfig.instance.themeStyle.submitBtn.configWidthConstraint(startBtnHeight)
        }
    }
    @IBOutlet weak var widgetButton: UIButton! {
        didSet {
            let padding = CGFloat(LocalConfig.instance.themeStyle.submitBtn.padding)
            let horizontalPadding =
                LocalConfig.instance.themeStyle.submitBtn.paddingHorizontal ?? padding
            let verticalPadding =
                LocalConfig.instance.themeStyle.submitBtn.paddingVertical ?? padding
            widgetButton.contentEdgeInsets =  UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
            widgetButton.layer.backgroundColor =
                LocalConfig.instance.themeStyle.submitBtn.backgroundColor.color.cgColor
            widgetButton.layer.borderWidth = CGFloat(LocalConfig.instance.themeStyle.submitBtn.borderWidth)
            widgetButton.layer.borderColor = LocalConfig.instance.themeStyle.submitBtn.borderColor.color.cgColor
            widgetButton.layer.cornerRadius = LocalConfig.instance.themeStyle.submitBtn.borderRadius
        }
    }
    @IBOutlet var containerView: UIView!
    var delegateWidgetResult: WidgetViewResult?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    @objc func onCloseSelector(_ sender: UITapGestureRecognizer) {
        delegateWidgetResult?.onTouch(true)
    }

    @objc func onButtonSelector(_ sender: UITapGestureRecognizer) {
        delegateWidgetResult?.onTouch(false)
    }

    @objc func onMainViewSelector(_ sender: UITapGestureRecognizer) {
        delegateWidgetResult?.onTouch(false)
    }

    func setup() {
        loadViewFromXib()
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        piWidgetClose.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.onCloseSelector(_:))))
        piWidgetMainbody.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.onMainViewSelector)))
        widgetButton.addTarget(self, action: #selector(self.onButtonSelector(_:)), for: .touchUpInside)
    }

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if outContainer.frame.contains(point) == true {
//            let childPoint = containerView.convert(point, to: outContainer)
//            if piWidgetClose.isHidden || (piWidgetClose.frame.contains(childPoint) == false) {
//                if delegateWidgetResult != nil {
//                    delegateWidgetResult?.onTouch(false)
//                }
////                self.disableWidget(cleanOnly: true)
//            } else {
//                delegateWidgetResult?.onTouch(true)
////                LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
////                self.disableWidget()
//            }
//            return containerView
//        } else {
//            delegateWidgetResult?.onTouch(true)
////            LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
////            self.disableWidget()
//            return nil
//        }
//    }

    func displayWidget() {
        self.changeToWidget(LocalConfig.instance.surveyPack.survey)
    }

    fileprivate func changeToWidget(_ surveyObj: SurveyCover) {
        buttonContainer.isHidden = surveyObj.invitationButtonDisable
        let attributeText = FormatSetTool.transferToHtmlFormatInAttribute(
        surveyObj.invitationButton.isEmpty ? "Start" : surveyObj.invitationButton,
        fontDetail: LocalConfig.instance.themeStyle.submitBtn.getFormater())
        widgetButton.setAttributedTitle(attributeText, for: .normal)

        let imgUrl: String = LocalConfig.instance.surveyPack.survey.background
        styledImage.imageUrl = imgUrl
        invitationLabel.setTitle(surveyObj.invitation, themeFont: LocalConfig.instance.themeStyle.largeFont.getFormater())
    }

//    open func disableWidget(cleanOnly: Bool = false ) {
//        if !cleanOnly {
//            LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
//        }
//        self.removeFromSuperview()
//    }

}
