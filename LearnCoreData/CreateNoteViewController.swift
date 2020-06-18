//
//  CreateNoteViewController.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/13/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content.layer.borderWidth = 1
        content.layer.borderColor = UIColor.lightGray.cgColor
        content.layer.cornerRadius = 5
        let saveButton = UIBarButtonItem(title: "Lưu", style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = saveButton
        
    }

    @objc func saveData(){
        guard let name = userName.text, let content = content.text else {
            return
        }
        Note.share.insertNewNote(ten: name, ghichu: content)
        self.navigationController?.popViewController(animated: true)
    }

}
