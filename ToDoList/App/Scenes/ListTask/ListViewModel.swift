//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import Foundation

protocol ListViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> TaskModel
}

class ListViewModel: ListViewModelProtocol {
    var tasks: [TaskModel] = [
        TaskModel(id: UUID().uuidString, title: "Estudar Swift"),
        TaskModel(id: UUID().uuidString, title: "Estudar Coordinator"),
        TaskModel(id: UUID().uuidString, title: "Estudar UserDefaults"),
    ]
    
    func numberOfRowsInSection() -> Int {
        return tasks.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> TaskModel {
        return tasks[indexPath.row]
    }
}
