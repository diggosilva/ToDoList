//
//  TaskModel.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import Foundation

class TaskModel: Codable {
    
    // MARK: - Properties
    var id: String
    var title: String
    var isCompleted: Bool = false
    var creationDate: Date = .now
    
    // MARK: - Initializer
    init(title: String) {
        self.id = UUID().uuidString
        self.title = title
    }
}
