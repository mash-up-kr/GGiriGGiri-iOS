//
//  CouponListRequestModel.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/07/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

struct GifticonListRequestModel: Encodable {
    let orderBy: CommonRequest.OrderCase
    let category: CommonRequest.CategoryCase
}
