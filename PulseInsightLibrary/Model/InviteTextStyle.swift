//
//  InviteTextStyle.swift
//  PulseInsights
//
//  Created by LeoChao on 2020/01/24.
//  Copyright © 2020 Pulse Insights. All rights reserved.
//

import Foundation

class InviteTextStyle: Decodable {

    var margin: Int?

    private enum CodingKeys: String, CodingKey {
        case margin
    }

    func getTheme() -> InviteTextTheme {
        let themeObj = InviteTextTheme()

        themeObj.margin = margin ?? themeObj.margin

        return themeObj
    }
}
