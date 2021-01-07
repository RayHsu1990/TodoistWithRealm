//
//  MainView.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import UIKit

class MainView : UIView {
    
    let tableView : UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        
        
        table.register(cellType: MainTableViewCell.self)
        return table
    }()
    

    
    init(){
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        tableViewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tableViewSetting(){
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
}
