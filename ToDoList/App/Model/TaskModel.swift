//
//  TaskModel.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import Foundation

class TaskModel {
    var id: String
    var title: String
    var isCompleted: Bool = false
    
    init(id: String, title: String) {
        self.id = UUID().uuidString
        self.title = title
    }
}
