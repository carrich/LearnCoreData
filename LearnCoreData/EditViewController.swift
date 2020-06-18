//
//  EditViewController.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/18/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var nameTextfield: UITextField!
    var name = ""
    var content = ""
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextfield.text = name
        contentTextView.text = content
        
    }


    @IBAction func saveBt(_ sender: Any) {
        guard let name = nameTextfield.text, let content = contentTextView.text else {
            return
        }
        Note.share.editDataByID(id: id, name: name, content: content)
        self.navigationController?.popViewController(animated: true)
    }
    

}
