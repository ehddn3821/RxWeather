//
//  ResultTableViewCell.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-16.
//

import UIKit
import Then
import SnapKit

final class ResultTableViewCell: UITableViewCell {
    
    let cityNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
