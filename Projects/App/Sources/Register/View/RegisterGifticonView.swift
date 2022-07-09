//
//  RegisterGifticonView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

final class RegisterGifticonView: CommonView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemPink
        return scrollView
    }()
    
    private let registerGiftionImageView = RegisterGiftionImageView()
    private let infoMessageView = InfoMessageView()
    
    override func setUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(registerGiftionImageView)
        scrollView.addSubview(infoMessageView)
        
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
    }
    
    func configure() {
        registerGiftionImageView.imageView.image = UIImage(systemName: "pencil")
    }
}


fileprivate class InfoMessageView: CommonView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "😲 중요해요!",
                                       font: .systemFont(ofSize: 16))
    
    private let infoLabel = TempLabel(color: .black,
                                      text: "등록해주신 기프티콘 이미지는 당첨자에게 전송될 때 사용되며, 등록 시 화면에는 카테고리 아이콘으로 대체됩니다. 미사용 바코드가 찍힌 기프티콘 사진을 업로드해주시길 바랍니다. ",
                                      font: .systemFont(ofSize: 12))
    
    override func setUI() {
        self.layer.cornerRadius = 8
        backgroundColor = .yellow
        
        addSubview(titleLabel)
        addSubview(infoLabel)
        
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
}

