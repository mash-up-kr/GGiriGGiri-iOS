//
//  RegisterGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

/// 기프티콘 정보 등록 화면
final class RegisterGifticonView: BaseView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .gray
        return scrollView
    }()
    
    private(set) var registerGiftionImageView = RegisterGiftionImageView()
    private let infoMessageView = InfoMessageView()
    private let registerGifticonInfoView = RegisterGifticonInfoView()
    private let registerGifticonDDipInfoView = RegisterGifticonDDipInfoView()
    private let registerButton = TempButton(title: "내용을 입력해야 뿌릴 수 있어요.")
    
    override func setLayout() {
        super.setLayout()
        
        scrollView.addSubviews(with: [registerGiftionImageView,
                                      infoMessageView,
                                      registerGifticonInfoView,
                                      registerGifticonDDipInfoView])
        addSubviews(with: [scrollView, registerButton])
        
        registerGiftionImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(294)
        }
        
        infoMessageView.snp.makeConstraints {
            $0.top.equalTo(registerGiftionImageView.snp.bottom)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(108)
        }
        
        registerGifticonInfoView.snp.makeConstraints {
            $0.top.equalTo(infoMessageView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(infoMessageView)
            $0.height.equalTo(475)
        }
        
        registerGifticonDDipInfoView.snp.makeConstraints {
            $0.top.equalTo(registerGifticonInfoView.snp.bottom).offset(48)
            $0.leading.trailing.equalTo(infoMessageView)
            $0.height.equalTo(122)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(registerGifticonDDipInfoView.snp.bottom)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(registerGifticonDDipInfoView.snp.bottom)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(46)
            $0.leading.trailing.equalTo(scrollView)
            $0.height.equalTo(54)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configure() {
        super.configure()
        
        registerGiftionImageView.imageView.image = UIImage(systemName: "pencil")
    }
}


fileprivate class InfoMessageView: BaseView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "😲 중요해요!",
                                       font: UIFont.pretendard(family: .bold, size: ._16))
    
    private let infoLabel = TempLabel(color: .black,
                                      text: "등록해주신 기프티콘 이미지는 당첨자에게 전송될 때 사용되며, 등록 시 화면에는 카테고리 아이콘으로 대체됩니다. 미사용 기프티콘인지 다시 한번 확인해주세요.",
                                      font: UIFont.pretendard(family: .regular, size: ._12))
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, infoLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(16)
            $0.trailing.equalTo(-248)
            $0.height.equalTo(20)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(16)
            $0.trailing.bottom.equalTo(-16)
            $0.height.equalTo(48)
        }
    }
    
    override func configure() {
        super.configure()
        
        self.layer.cornerRadius = 8
        backgroundColor = .yellow
    }
}

