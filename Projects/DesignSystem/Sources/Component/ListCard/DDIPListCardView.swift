//
//  DDIPListCardView.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/17.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPListCardView: UIView, AddViewsable {
    public let style: DDIPListCardViewStyle
    private let alarmButton: DDIPCardListButton
    private let viewer: DDIPListViewer
    
    public let nameLabel = UILabel()
    public let brandLabel = UILabel()
    public let expirationLabel = UILabel()
    public let imageIcon = UIImageView()
    public let dashedLine = UIView()
    public let descriptionLabel = UILabel()
    
    public let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
                                    
        return stackView
    }()
    
    public let drawStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    public init(
        frame: CGRect = .zero,
        style: DDIPListCardViewStyle,
        alarmButton: DDIPCardListButton,
        viewer: DDIPListViewer
    ) {
        self.style = style
        self.alarmButton = alarmButton
        self.viewer = viewer
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 8
        setView()
        setUI()
        setValue()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        viewer.translatesAutoresizingMaskIntoConstraints = false
        alarmButton.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        dashedLine.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubViews([infoStackView, imageIcon, viewer, dashedLine, drawStackView])
        infoStackView.addArrangedSubviews(with: [brandLabel, nameLabel, expirationLabel])
        drawStackView.addArrangedSubviews(with: [alarmButton, descriptionLabel])
        dashedLine.makeDashedBorderLine(color: .blue, strokeLength: 8, gapLength: 2, width: 1)
    }
    
    private func setValue() {
        brandLabel.text = style.brand
        nameLabel.text = style.name
        expirationLabel.text = style.expirationDate
        imageIcon.image = UIImage(systemName: style.iconImage)
        descriptionLabel.text = style.description
        
        dashedLine.createDottedLine(width: 1, color: UIColor.black.cgColor)
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: -17),
            infoStackView.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            imageIcon.trailingAnchor.constraint(equalTo: viewer.leadingAnchor, constant: -1),
            imageIcon.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -10),
            imageIcon.widthAnchor.constraint(equalToConstant: 75),
            imageIcon.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            viewer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9),
            viewer.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            viewer.bottomAnchor.constraint(equalTo: dashedLine.topAnchor, constant: -68)
        ])
        
        NSLayoutConstraint.activate([
            dashedLine.heightAnchor.constraint(equalToConstant: 1),
            dashedLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dashedLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dashedLine.bottomAnchor.constraint(equalTo: drawStackView.topAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            drawStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            drawStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            drawStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}

extension UIView {
    func createDottedLine(width: CGFloat, color: CGColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [2,4]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: self.bounds.minX, y: 0), CGPoint(x: 304, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}
