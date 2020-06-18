//
//  Note+CoreDataFunction.swift
//  LearnCoreData
//
//  Created by Ngoduc on 6/13/20.
//  Copyright © 2020 com.techmaster.D. All rights reserved.
//

import Foundation
import CoreData
extension Note{
    static var share = Note()
    // tạo 1 hàm để thêm dữ liệu vào database
    func insertNewNote(ten username: String,ghichu content: String) -> Note?{
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: AppDelegate.managerObjectContext!) as! Note
        note.id = UUID().uuidString // hàm UUID().uuidString để generate ra các chuỗi ký tự không trùng nhau
        note.username = username
        note.content = content
        note.isSelected = false
        note.date = "13-06-2020"
        
        //tiến hành lưu dữ liệu vào database
        do {
            try AppDelegate.managerObjectContext?.save()
        } catch  {
            let nsError = error as NSError
            print("Không thể thêm ghi chú. lỗi là \(nsError), \(nsError.userInfo)")
            return nil
        }
        print("Thêm ghi chú thành công \(note.content ?? ""), \(note.username ?? "")")
        return note
        
    }
    func getRequest(entityName: String) -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest(entityName: entityName)
    }
    func findBy(entityName: String, predicate: NSPredicate?, success: (([NSManagedObject]?) -> Void)?, fail: ((Error) -> Void)?){
        let request = getRequest(entityName: entityName)
        request.predicate = predicate
        do {
            let result = try AppDelegate.managerObjectContext?.fetch(request)
            success?(result)
        } catch  {
            fail?(error)
        }
    }
    func searchCoreData(_ text: String) -> [Note]{
        var notes = [Note]()
        print("search")
        let predicate = NSPredicate(format: "content contains[c] %@", "\(text)")
        findBy(entityName: "Note", predicate: predicate, success: { (user) in
            guard let user = user as? [Note] else { return }
            notes = user
            for item in user {
                
                print(item.content ?? "Không tìm thấy")
            }
            
        }) { (err) in
            print("Error is \(err)")
        }
        return notes
    }
    //tạo hàm lấy toàn bộ dữ liệu
    func getAllNote() -> [Note]{
        var result = [Note]()
        let moc = AppDelegate.managerObjectContext
        do {
            result = try moc!.fetch(Note.fetchRequest()) as! [Note]
        } catch{
            print("Không thể fetch dữ liệu. lỗi là \(error)")
            return result
        }
        return result
    }
    
    //tạo 1 hàm delete xoá toàn bộ
    func getDeleteAllData(){
        let moc = AppDelegate.managerObjectContext
        let notes = Note.share.getAllNote()
        for item in notes {
            moc?.delete(item)
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            print("Xoá toàn bộ")
        } catch  {
            let nsErros = error as NSError
            print("Không thể xoá \(nsErros), \(nsErros.userInfo)")
        
        }
    }
    func deleteDataByID(_ id: String){
        let moc = AppDelegate.managerObjectContext
        let notes = Note.share.getAllNote()
        for item in notes {
            if item.id == id {
                moc?.delete(item)
            }
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            print("Xoá dư liệu với id \(id) thành công")
        } catch  {
            let nsErros = error as NSError
            print("Không thể xoá dữ liệu \(nsErros), \(nsErros.userInfo)")
        
        }
    }
    func editDataByID(id: String,name: String, content: String){
        let moc = AppDelegate.managerObjectContext
        let notes = Note.share.getAllNote()
        for item in notes {
            if item.id == id {
                item.username = name
                item.content = content
            }
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            print("Xoá dư liệu với id \(id) thành công")
        } catch  {
            let nsErros = error as NSError
            print("Không thể xoá dữ liệu \(nsErros), \(nsErros.userInfo)")
        
        }
    }
    
}
