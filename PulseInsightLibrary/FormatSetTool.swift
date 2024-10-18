//
//  FormatSetTool.swift
//  PulseInsightLibrary
//
//  Created by LeoChao on 2016/12/20.
//  Copyright © 2016 Pulse Insights. All rights reserved.
//

import Foundation
import UIKit

let targetIdBold: NSInteger = 0
let targetIdItalic: NSInteger = 1
let aryStringPreFix: [String] = ["<b>", "<em>"]
let aryStringPostFix: [String] = ["</b>", "</em>"]
var aryMarkCount: [NSInteger] = [0, 0]
var listRecord: [NSInteger] = [NSInteger]()

class FormatSetTool {
    class func transferToHtmlFormatInAttribute(_ strOriString: String, fontDetail: FontFormater, pressEffect: Bool = false, setTextAlign: String = "") -> NSAttributedString {
        var textColor: UIColor {
            if pressEffect {
                print("pressEffect/on")
                return LocalConfig.instance.themeStyle.ansBtn.tabEffectTextColor.color
            } else {
                print("pressEffect/off")
                return fontDetail.fontColor.color
            }
        }
        var textAlign: String {
            if setTextAlign.isEmpty {
                return fontDetail.alignment
            } else {
                return setTextAlign
            }
        }

        return transferToHtmlFormatInAttribute(strOriString,
                                               fontSize: fontDetail.fontSize,
                                               textColor: textColor,
                                               fontFamily: fontDetail.fontFace,
                                               textAlign: textAlign,
                                               fontWeight: fontDetail.fontWeight,
                                               fontStyle: fontDetail.fontStyle)
    }

    class func transferToHtmlFormatInAttribute(_ strOriString: String,
                                               fontSize: NSInteger = 18,
                                               textColor: UIColor = LocalConfig.instance.themeStyle.textColor.color,
                                               fontFamily: String = "sans-serif",
                                               textAlign: String = "left",
                                               fontWeight: CGFloat = 300.0,
                                               fontStyle: String = "normal") -> NSAttributedString {

        let strHtmlFormatHead: String = "<html><head><meta charset=\"UTF-8\"><style type=\"text/css\">body " +
        "{font-size: \(String(fontSize))pt; font-family: \(fontFamily); text-align: \(textAlign); font-style: \(fontStyle); font-weight: \(fontWeight)}</style></head><body>"
        let strHtmlFormatFooter: String = "</body></html>"
        let fullRawText = "\(strHtmlFormatHead)\(strOriString)\(strHtmlFormatFooter)"
        let attrStr = try? NSMutableAttributedString  (
            data: self.transferToHtmlFormat(fullRawText)
                .data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ .documentType: NSAttributedString.DocumentType.html,
                       .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        let haveItalic = fontStyle.compare("italic", options: NSString.CompareOptions.caseInsensitive) == .orderedSame
        let haveOblique = fontStyle.compare("oblique", options: NSString.CompareOptions.caseInsensitive) == .orderedSame
        if (haveItalic || haveOblique) {
            attrStr?.addAttributes([NSAttributedString.Key.obliqueness: 0.2], range: NSRange(location: 0, length: attrStr?.string.utf16.count ?? 0))
        }
        let systemFont = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight == 700 ? .bold : .regular)
        attrStr?.addAttributes([NSAttributedString.Key.font: systemFont], range: NSRange(location: 0, length: attrStr?.string.utf16.count ?? 0))
        let style = NSMutableParagraphStyle()
        if textAlign == "center" {
            style.alignment = .center
        } else if textAlign == "right" {
            style.alignment = .right
        } else {
            style.alignment = .left
        }
        style.lineBreakMode = .byWordWrapping
        style.lineSpacing = 1
        attrStr?.addAttributes([NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.foregroundColor: textColor], range: NSRange(location: 0, length: attrStr?.string.utf16.count ?? 0))

        // Sould measure the length in utf16 because the input cases might have the emoji
        // According this thread: https://stackoverflow.com/a/56471065
        // If not, the displyed emoji might broken/hided

        return attrStr!
    }

    class func transferToHtmlFormat(_ strOriString: String) -> String {
        var strRtItem: String = ""
        var listRecord: [NSInteger] = [NSInteger]()
        var iCountMarkBold: NSInteger = 0
        var iCountMarkItalic: NSInteger = 0
        var iTempSum: NSInteger = 0

        iCountMarkBold = countMatch(strOriString, strTarget: "*")
        iCountMarkBold = (iCountMarkBold > 0) ? ( (iCountMarkBold%2 == 0) ? iCountMarkBold : (iCountMarkBold - 1) ) : 0
        iTempSum+=iCountMarkBold
        iCountMarkItalic = countMatch(strOriString, strTarget: "_")
        iCountMarkItalic = (iCountMarkItalic > 0) ?
            ( (iCountMarkItalic%2 == 0) ? iCountMarkItalic : (iCountMarkItalic - 1) ) : 0
        iTempSum+=iCountMarkItalic

        aryMarkCount[targetIdBold] = iCountMarkBold
        aryMarkCount[targetIdItalic] = iCountMarkItalic

        if iTempSum>0 {
            let aryTemp: [Character] = Array(strOriString)

            for cTemp in aryTemp {
                if (cTemp == "*") || (cTemp == "_") {
                    var strAdded: String = ""
                    let iTargetID: NSInteger = (cTemp == "*") ? targetIdBold : targetIdItalic
                    if aryMarkCount[iTargetID]>0 {
                        if aryMarkCount[iTargetID]%2 == 0 {
                            strAdded = aryStringPreFix[iTargetID]
                            listRecord.append(iTargetID)
                        } else {
                            strAdded = getPostFixTag(iTargetID)
                        }
                        aryMarkCount[iTargetID] -= 1
                    } else {
                        strAdded = String(cTemp)
                    }
                    strRtItem += strAdded
                } else {
                    strRtItem += String(cTemp)
                }
            }
        } else {
            strRtItem = strOriString
        }
        return strRtItem
    }
}
func getPostFixTag(_ iOnCloseType: NSInteger) -> String {
    var strRt: String = ""
    var strContinuePreFix: String = ""
    var listAdditional: [NSInteger] = [NSInteger]()
    while listRecord.count>0 {
        let iLastIndex: NSInteger = listRecord.count-1
        let iLastTypeID: NSInteger = listRecord[iLastIndex]
        listRecord.remove(at: iLastIndex)
        strRt+=aryStringPostFix[iLastTypeID]
        if iOnCloseType == iLastTypeID {
            break
        } else {
            strContinuePreFix  = aryStringPreFix[iLastTypeID] + strContinuePreFix
            listAdditional.append(iLastTypeID)
        }
    }
    if listAdditional.count>0 {
        listAdditional = listAdditional.reversed()
        for iTmpItem in listAdditional {
            listRecord.append(iTmpItem)
        }
    }

    return strRt
}
func countMatch(_ strSource: String, strTarget: String ) -> NSInteger {
    var iTmp: NSInteger = 0

    if strTarget.count>0 && strSource.count>strTarget.count {
        iTmp = strSource.count - strSource.replacingOccurrences(of: strTarget, with: "").count
        iTmp /= strTarget.count
    }

    return iTmp
}
