//
//  ContView.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import UIKit


class ContentView: UIView {
    
    let textView: UITextView = {
        
        let textView = UITextView()
        textView.layer.cornerRadius = 20
        textView.backgroundColor = #colorLiteral(red: 0.8838654062, green: 0.9277673952, blue: 0.8237252914, alpha: 1)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.font = .systemFont(ofSize: 22)
        textView.becomeFirstResponder()

        return textView
    }()
    
    init(){
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        textViewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewSetting(){
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 300)
        ])

    }
    
}
