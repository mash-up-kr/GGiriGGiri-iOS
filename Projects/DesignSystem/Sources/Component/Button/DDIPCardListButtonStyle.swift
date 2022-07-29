//
//  DDIPCardListButtonStyle.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public struct DDIPCardListButtonStyle {
    public enum TitleStatus: String {
        case apply = "응모하기"
        case complete = "응모완료"
        case result = "결과확인"
        case progress = "응모중"
        case failure = "꽝"
        case win = "당첨"
    }
    
    public let buttonColor: UIColor
    public let title: TitleStatus?
    public let isHidden: Bool

    public init(
        buttonColor: UIColor,
        title: TitleStatus?,
        isHidden: Bool
    ) {
        self.buttonColor = buttonColor
        self.title = title
        self.isHidden = isHidden
    }
}
