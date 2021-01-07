//
//  MainTableViewCell.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import UIKit
import Reusable

class MainTableViewCell : UITableViewCell, Reusable {
    
    private let titleLabel = UILabel()
    
    func configure(list: ListModel){
        titleSetting()
        titleLabel.text = list.title
    }
    
    func titleSetting(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

    }
}
