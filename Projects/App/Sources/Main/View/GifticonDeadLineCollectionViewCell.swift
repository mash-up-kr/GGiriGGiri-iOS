//
//  GifticonDeadLineCollectionViewCell.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/06/26.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import DesignSystem
import SnapKit
import Kingfisher

final class GifticonDeadLineCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GifticonDeadLineCollectionViewCell"
    
    private(set) var gifticonId = 0
    private let brandLabel = TempLabel(color: .black)
    private let nameLabel = TempLabel(color: .black)
    private let expirationDateLabel = TempLabel(color: .black)
    private(set) var isParticipatingButton = TempButton(title: "지금 당장 응모할게요!")
    private let numberOfParticipantsViewLabel = TempLabel(color: .black)
    private let remainingTimeLabel = TempLabel(color: .black)
    
    private let cardView = DDIPDeadlineView(
        /// 빈값으로 만들 수 있어야 하고
        ///  전반적으로 컴포넌트들이 외부에서 수정 할 수 없게 되어있음
        style: .init(time: "시간",
                     brand: "브랜드",
                     name: "이름",
                     expirationDate: "유효기간",
                     iconImage: "아이콘이미지"),
        button: .init(style: .init(buttonColor: .designSystem(.secondaryBlue) ?? .label,
                                   titleColor: .designSystem(.neutralWhite) ?? .label,
                                   title: "지금당장응모할게용")),
        applyViewer: .init(viewLabel: "오잉?")
    )
    
    private let gifticonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    func configure(with data: GifticonCard) {
        /// 전달받은 값을 반영할 수 있어야 한다
        gifticonId = data.gifticonInfo.id
        brandLabel.text = data.gifticonInfo.brand
        nameLabel.text = data.gifticonInfo.name
        expirationDateLabel.text = data.gifticonInfo.expirationDate
        numberOfParticipantsViewLabel.text = "\(data.numberOfParticipants)"
        remainingTimeLabel.text = data.remainingTime
        gifticonImageView.kf.setImage(with: data.gifticonInfo.url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//
//        contentView.addSubview(verticalStackView)
//
//        verticalStackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        verticalStackView.addArrangedSubviews(with: [gifticonImageView,
//                                                     brandLabel,
//                                                     nameLabel,
//                                                     expirationDateLabel,
//                                                     numberOfParticipantsViewLabel,
//                                                     remainingTimeLabel,
//                                                     isParticipatingButton])
    }
}
