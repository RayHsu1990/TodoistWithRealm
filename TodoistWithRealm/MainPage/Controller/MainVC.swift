//
//  ViewController.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import UIKit

class MainVC: UIViewController {
    
    private let baseView = MainView()
    
    var lists  = [ListModel]() {
        didSet {
            baseView.tableView.reloadData()
            RealmManager.shared.add(objects: lists)
        }
    }
    
    
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
        navigationItem.title = " To Do "
        navigationItem.setRightBarButton(
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector (add)
            ),
            animated: true
        )
        lists = RealmManager.shared.read()
    }
    
    @objc private func add(){
        presentAlert()
    }
    
    private func presentAlert(){
        let alert = UIAlertController(title: "New",
                                      message: "add a new TODO",
                                      preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "text something...." }
        
        let addAction = UIAlertAction(title: "OK",
                                      style: .default) { [unowned self]_ in
            guard let title = alert.textFields?.first?.text else { return }
            
            let list = ListModel()
            list.title = title
            lists.append(list)
            let vc = ContentVC(list: list)
            vc.delegate = self
            navigationController?.pushViewController(vc ,
                                                     animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
//MARK:- 傳值Delegate

extension MainVC : ContentEdidDelegate {
    
    func contentEdited(list: ListModel, indexPath: IndexPath?) {
        guard let indexPath = indexPath else  { return }
        lists[indexPath.row] = list
    }
    
    func contentDelete(indexPath: IndexPath?) {
        let index = indexPath == nil ? lists.count - 1 : indexPath!.row
        lists.remove(at: index)
    }

}
//MARK:- UITableViewDataSource

extension MainVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MainTableViewCell
        
        cell.configure(list: lists[indexPath.row])
        
        return cell
    }
    
}
//MARK:- UITableViewDelegate

extension MainVC :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ContentVC(list: lists[indexPath.row], indexPath: indexPath)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RealmManager.shared.delete(list: lists[indexPath.row])
            lists.remove(at: indexPath.row)
        }
    }
}

