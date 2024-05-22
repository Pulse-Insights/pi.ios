//
//  SurveyMainViewController.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/22.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import UIKit

class SurveyMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var piSurveyView: SurveyView!

    @IBOutlet weak var invitationWidget: WidgetView!
    @IBOutlet weak var backOverlayView: UIView!

    @IBOutlet weak var allQuestionsView: UITableView!
    @IBOutlet weak var surveyMarginTop: NSLayoutConstraint!
    @IBOutlet weak var surveyMarginBottom: NSLayoutConstraint!
    var surveyAnswers = SurveyAnswers()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.modalPresentationStyle = .custom
        let podBundle = Bundle(for: PulseInsights.self)
        podBundle.loadNibNamed("SurveyMainViewController", owner: self, options: nil)
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        UIApplication.shared.isStatusBarHidden = true

        let actTapWidgetOutside = UITapGestureRecognizer(target: self, action: #selector(self.tapOutRangeOfWidget(_:)))
        backOverlayView.addGestureRecognizer(actTapWidgetOutside)
        invitationWidget.isHidden = true
        piSurveyView.isHidden = true
        piSurveyView.delegateViewResult = self
        invitationWidget.delegateWidgetResult = self
        let surveyType = LocalConfig.instance.surveyPack.survey.surveyType
        if surveyType != .inline && !LocalConfig.instance.surveyPack.survey.invitation.isEmpty {
            self.changeToInviteWidget()
        } else {
            self.changeToSurveyMain()
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var topMoves = CGFloat(0)
            if self.view.frame.origin.y == 0 && surveyMarginTop.constant > 0 {
                topMoves = surveyMarginTop.constant
                self.view.frame.origin.y -= topMoves
            }
            if surveyMarginBottom.constant == 0 {
                surveyMarginBottom.constant += (keyboardSize.height - topMoves)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var topMoves = CGFloat(0)
            if self.view.frame.origin.y < 0 {
                topMoves = surveyMarginTop.constant
                self.view.frame.origin.y += topMoves
            }
            if surveyMarginBottom.constant >= 0 {
                surveyMarginBottom.constant -= (keyboardSize.height - topMoves)
            }
        }
    }
    @objc func tapCloseButtonOfWidget(_ sender: UITapGestureRecognizer) {
        self.disableSurvey()
    }
    @objc func tapOutRangeOfWidget(_ sender: UITapGestureRecognizer) {
        self.disableSurvey()
    }
    @objc func tapInsideOfWidget(_ sender: UITapGestureRecognizer) {
        self.changeToSurveyMain()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL, imageView:UIImageView!, imageHeighConstrain:NSLayoutConstraint!) {
        print("Download Started/URL = \(url)")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                imageView.contentMode = .scaleAspectFit
                var imageHeight: CGFloat? = 0.0
                var imageWidth: CGFloat? = 0.0
                if(imageView.image?.size.height != nil) {
                    imageHeight = imageView.image?.size.height
                }
                if(imageView.image?.size.width != nil) {
                    imageWidth = imageView.image?.size.width
                }
                if imageView.frame.size.width < (imageWidth)! {
                    imageHeighConstrain.constant =
                        imageView.frame.size.width * (imageHeight)! / (imageWidth)!

                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func closeKeyboard() {
        //pi_survey_content_text!.txtInputPart.endEditing(true)
    }
    func tapSurveyAround(_ sender: UITapGestureRecognizer) {
        closeKeyboard()
    }

    open func disableSurvey() {
        LocalConfig.instance.iSurveyEventCode = Define.piEventCodeSurveyJustClosed
        self.dismiss(animated: true, completion: nil)
    }

    fileprivate func changeToInviteWidget() {
        print("Main height: \( self.view.bounds.height)")
        piSurveyView.isHidden = true
        invitationWidget.isHidden = false
        invitationWidget.displayWidget()
    }

    fileprivate func changeToSurveyMain() {
        var viewHeight = UIScreen.main.bounds.height
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top ?? 0
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            viewHeight -= ( topPadding + bottomPadding )
        }
        let surveyType = LocalConfig.instance.surveyPack.survey.surveyType
        if surveyType == .bottom_bar {
            let inputWidgetHeight = LocalConfig.instance.surveyPack.survey.widgetHeight
            if inputWidgetHeight <= 0 {
                surveyMarginTop.constant = CGFloat(viewHeight/2)
            } else {
                let percentHeight = 100 - min(100, inputWidgetHeight)
                surveyMarginTop.constant = viewHeight * CGFloat(percentHeight) / 100
            }
        } else {
            surveyMarginTop.constant = CGFloat(0)
        }
        invitationWidget.isHidden = true
        if (LocalConfig.instance.surveyPack.survey.displayAllQuestions) {
            allQuestionsView.dataSource = self
            allQuestionsView.delegate = self
            allQuestionsView.register(SurveyItemTableViewCell.self, forCellReuseIdentifier: "SurveyItemCell")
            piSurveyView.isHidden = true
            allQuestionsView.isHidden = false
        } else {
            piSurveyView.isHidden = false
            piSurveyView.setupSurveyContent(LocalConfig.instance.surveyTickets)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalConfig.instance.surveyTickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyItemCell", for: indexPath) as! SurveyItemTableViewCell
        let surveyItem = LocalConfig.instance.surveyTickets[indexPath.row]
        cell.surveyItemView.displayCloseButton(indexPath.row == 0)
        cell.surveyItemView.delegateViewResult = self
        cell.surveyItemView.setupSurveyItem(surveyItem)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear

        let button = UIButton(type: .system)
        
        button.setTitle(LocalConfig.instance.surveyPack.survey.allAtOnceSubmitLabel, for: .normal)
        button.addTarget(self, action: #selector(didTapFooterButton), for: .touchUpInside)

        footerView.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }

    @objc func didTapFooterButton() {
        // print("Footer button tapped", surveyAnswers.getAnswers())
        PulseInsightsAPI.postAllAtOnce(surveyAnswers.getAnswers()) { bResult in
            self.disableSurvey()
        }
    }
}
extension SurveyMainViewController: SurveyViewResult {
    func onFinish() {
        disableSurvey()
    }
}

extension SurveyMainViewController: WidgetViewResult {
    public func onTouch(_ doClose: Bool) {
        if doClose {
            disableSurvey()
        } else {
            changeToSurveyMain()
        }
    }
}

extension SurveyMainViewController: SurveyItemTableViewCellDelegate {
    func onItemAnswerSelected(_ cell: SurveyItemTableViewCell, didUpdateAnswer answer: String) {
        if let ticket = cell.surveyItemView.getCurrentSurveyData() {
            // Add to list
            surveyAnswers.setAnswer(questionId: ticket.surveyId, questionType: ticket.questionType, answer: answer)
        }
    }
}
