//
//  ViewController.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/13/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var notes = [Note]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("se xuat hien")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notes = Note.share.getAllNote()
        tableView.reloadData()
        print("daxuathien")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier: "CustomViewCell")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createData))
        navigationItem.rightBarButtonItem = addButton
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(deleteData))
        navigationItem.leftBarButtonItem = deleteButton
        deleteButton.tintColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        createSearchBar()
    }
    @objc func createData(){
        let createV = CreateNoteViewController()
        navigationController?.pushViewController(createV, animated: true)
        tableView.reloadData()
    }
    @objc func deleteData(){
        Note.share.getDeleteAllData()
        tableView.reloadData()
    }
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
        searchBar.placeholder = "Enter your search here"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  notes.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eV = EditViewController()
        eV.name = notes[indexPath.row].username!
        eV.content = notes[indexPath.row].content!
        eV.id = notes[indexPath.row].id
        self.navigationController?.pushViewController(eV, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomViewCell", for: indexPath) as! CustomViewCell
        cell.name.text = notes[indexPath.row].username
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        cell.date.text = formatter.string(from: Date()) 
        cell.conten.text = notes[indexPath.row].content
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            Note.share.deleteDataByID(self.notes[indexPath.row].id)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        guard let term = searchBar.text  else {
            
            //Notification "White spaces are not permitted"
            return
        }
        
        //Filter function
        
        
        print(term)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "" {
            notes = Note.share.getAllNote()
            tableView.reloadData()
        } else {
            notes =  Note.share.searchCoreData(searchText)
            tableView.reloadData()
        }
        
    }
}
