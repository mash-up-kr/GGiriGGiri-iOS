//
//  DDIPListCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay

public class DDIPListCardView: UIView, AddViewsable {
    public enum ViewType {
        case apply           // 응모하기, 응모완료
        case appliedStatus   // 결과확인, 응모중, 꽝, 당첨
        case drawStatus      // 전달완료, 진행중, 받은사람 없음
    }
    
    public enum DrawStatus: String {
        /// 응모 진행 중
        case apply
        
        /// 전달 완료
        case complete
        
        /// 받은 사람 없음
        case nobody
        
        /// drawLabel에 적용될 문구
        var description: String {
            switch self {
            case .apply: return "응모 진행 중"
            case .complete: return "전달 완료"
            case .nobody: return "받은 사람 없음"
            }
        }
    }

    private var type: ViewType {
        didSet {
            updateFromApplyStatus()
        }
    }
    private let applyViewer = DDIPApplyViewer()
    private let nameLabel = UILabel()
    private let brandLabel = UILabel()
    private let expirationLabel = UILabel()
    private let imageIcon = UIImageView()
    private let dashedLine = DashedLine()

    public let productStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    public let componentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let semiCircleSpaceLeftView: SpaceView = {
        let view = SpaceView(isClockwise: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    private let semiCircleSpaceRightView: SpaceView = {
        let view = SpaceView(isClockwise: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let deadlineViewComponent: DDipListCardDeadlineView = {
        let view = DDipListCardDeadlineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let applyViewComponent: DDipListCardApplyView = {
        let view = DDipListCardApplyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let completeViewCmponent: DDipListCardCompleteView = {
        let view = DDipListCardCompleteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let cardListButtonDidTapped = PublishRelay<ViewType?>()
    private let disposeBag = DisposeBag()
    
    public init(type: ViewType) {
        self.type = type
        super.init(frame: .zero)
        setView()
        setUI()
        setAttribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        applyViewer.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([
            productStackView,
            imageIcon,
            applyViewer,
            dashedLine,
            semiCircleSpaceLeftView, semiCircleSpaceRightView,
            componentStackView
        ])
        productStackView.addArrangedSubviews(
            brandLabel,
            nameLabel,
            expirationLabel
        )
        componentStackView.addArrangedSubviews(
            deadlineViewComponent,
            applyViewComponent,
            completeViewCmponent
        )
    }
    
    private func setAttribute() {
        self.backgroundColor = .designSystem(.neutralWhite)
        self.layer.cornerRadius = 8

        brandLabel.textColor = .designSystem(.neutralBlack)
        nameLabel.textColor = .designSystem(.neutralBlack)
        expirationLabel.textColor = .designSystem(.neutralGray500)

        brandLabel.font = .designSystem(.pretendard, family: .medium, size: ._12)
        nameLabel.font = .designSystem(.pretendard, family: .bold, size: ._18)
        expirationLabel.font = .designSystem(.pretendard, family: .regular, size: ._12)
        
        updateFromApplyStatus()
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            productStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            productStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            productStackView.trailingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75),
            
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            imageIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55)
        ])
        
        NSLayoutConstraint.activate([
            applyViewer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            applyViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.heightAnchor.constraint(equalToConstant: 1),
            
            dashedLine.leadingAnchor.constraint(equalTo: self.semiCircleSpaceLeftView.trailingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.semiCircleSpaceRightView.leadingAnchor),
            dashedLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -82)
        ])
        
        NSLayoutConstraint.activate([
            semiCircleSpaceLeftView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceLeftView.widthAnchor.constraint(equalToConstant: 18),
            
            semiCircleSpaceLeftView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -9),
            semiCircleSpaceLeftView.centerYAnchor.constraint(equalTo: self.dashedLine.centerYAnchor),
            
            semiCircleSpaceRightView.heightAnchor.constraint(equalToConstant: 18),
            semiCircleSpaceRightView.widthAnchor.constraint(equalToConstant: 18),
            
            semiCircleSpaceRightView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 9),
            semiCircleSpaceRightView.centerYAnchor.constraint(equalTo: self.dashedLine.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            componentStackView.topAnchor.constraint(equalTo: productStackView.bottomAnchor, constant: 42),
            componentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            componentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            componentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
    
    private func bind() {
        Observable.merge(
            deadlineViewComponent.cardListButton.rx.tap.asObservable(),
            applyViewComponent.cardListButton.rx.tap.asObservable(),
            completeViewCmponent.cardListButton.rx.tap.asObservable()
        )
        .map { [weak self] in self?.type }
        .bind(to: cardListButtonDidTapped)
        .disposed(by: disposeBag)
    }
    
    private func updateFromApplyStatus() {
        switch type {
        case .apply:
            deadlineViewComponent.isHidden = false
            applyViewComponent.isHidden = true
            completeViewCmponent.isHidden = true
        case .appliedStatus:
            deadlineViewComponent.isHidden = true
            applyViewComponent.isHidden = false
            completeViewCmponent.isHidden = true
        case .drawStatus:
            deadlineViewComponent.isHidden = true
            applyViewComponent.isHidden = true
            completeViewCmponent.isHidden = false
        }
    }
}

// MARK: - 외부 주입 메서드

extension DDIPListCardView {
    public func setApplyViewType(
        status: DDIPCardListButton.ApplyStatus,
        leftTime: Date
    ) {
        type = .apply
        
        deadlineViewComponent.setCardListButton(status)
        
        let drawLabelTitle: String  = {
            switch status {
            case .enable: return "마감"
            case .complete: return "결과"
            }
        }()

        deadlineViewComponent.setDrawLabel(title: drawLabelTitle, leftTime: leftTime)
    }

    public func setAppliedStatusViewType(
        status: DDIPCardListButton.AppliedStatus,
        applyDate: Date
    ) {
        type = .appliedStatus
        
        applyViewComponent.setCardListButton(status)
        applyViewComponent.setDrawLabel(applyDate: applyDate)
    }
    
    public func setDrawStatusViewType(
        drawDate: Date? = nil,
        status: DrawStatus
    ) {
        type = .drawStatus
        
        completeViewCmponent.setDrawLabel(drawDate: drawDate, registerStatus: status.description)
    }

    public func setBrandName(brand: String) {
        brandLabel.text = brand
    }

    public func setName(name: String) {
        nameLabel.text = name
    }

    public func setExpirationDate(expirationDate: Date) {
        expirationLabel.text = "유효기간 : \(expirationDate.fullDateString(.dot))"
    }

    public func setImageIcon(image: DDIPAsset.name) {
        imageIcon.image = .designSystem(image)
    }

    public func setApplyViewer(viewer: Int) {
        applyViewer.setViewer(viewer: viewer)
    }
}
