//
//  FontBaseTheme.swift
//  PulseInsights
//
//  Created by LeoChao on 2019/11/19.
//  Copyright © 2019 Pulse Insights. All rights reserved.
//

import Foundation

open class FontBaseTheme {
    var fontFace = "sans-serif"
    var fontSize = 12
    var fontColor = ColorObject(textCode: "#000000")
    var alignment = "left"
    var style = "normal"

    init(_ fontSize: Int = 12) {
        self.fontSize = fontSize
    }

    func getFormater() -> FontFormater {
        let formater = FontFormater()
        formater.alignment = alignment
        formater.fontSize = fontSize
        formater.fontFace = fontFace
        formater.fontColor = fontColor
        formater.fontStyle = style
        return formater
    }

    func applyNewStyle(newStyle: FontBaseTheme) {
        self.fontFace = newStyle.fontFace
        self.fontSize = newStyle.fontSize
        self.fontColor.code = newStyle.fontColor.code
        self.alignment = newStyle.alignment
        self.style = newStyle.style
    }

    func updateWithStyle(_ style: FontStyleBase) {
        self.fontFace.updateIfNeed(newValue: style.fontFace)
        self.fontSize.updateIfNeed(newValue: style.fontSize)
        self.fontColor.code.updateIfNeed(newValue: style.fontColor)
        self.alignment.updateIfNeed(newValue: style.alignment)
        self.style.updateIfNeed(newValue: style.style)
    }
}
