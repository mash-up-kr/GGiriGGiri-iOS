//
//  BaseHeaderView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/25.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit

final class BaseHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "BaseHeaderView"
    
    private(set) var titleLabel = TempLabel(color: .black,
                                            font: .designSystem(.pretendard, family: .bold, size: ._16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.top).offset(14)
            $0.bottom.equalTo(self.snp.bottom).offset(-24)
        }
    }
}
