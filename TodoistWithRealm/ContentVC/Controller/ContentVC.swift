//
//  ContentVC.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import UIKit

class ContentVC: UIViewController {
    
    let baseView = ContentView()
    
    var list : ListModel!
    
    var delegate : ContentEdidDelegate?
    
    var indexPath : IndexPath?
    
    init(list: ListModel, indexPath : IndexPath? = nil){
        super.init(nibName: nil, bundle: nil)
        self.list = list
        
        if let indexPath = indexPath {
            self.indexPath = indexPath
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = list.title
        baseView.textView.text = list.text
        baseView.textView.delegate = self
        
        navigationItem.setRightBarButton(
            UIBarButtonItem(barButtonSystemItem: .trash,
                            target: self,
                            action: #selector (deleteList)
            ),
            animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let list = list {
            delegate?.contentEdited(list: list, indexPath: indexPath)

        }
        
    }
    
    @objc func deleteList(){
        RealmManager.shared.delete(list: list){ [unowned self] in
            list = nil
            delegate?.contentDelete(indexPath: indexPath)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    

}
//MARK:- UITextViewDelegate
extension ContentVC : UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let text = textView.text else { return }
        RealmManager.shared.updateContent(list: list, text: text)
    }
}



protocol ContentEdidDelegate {
    
    func contentEdited(list:ListModel, indexPath : IndexPath?)
    
    func contentDelete(indexPath : IndexPath?)
    
}
