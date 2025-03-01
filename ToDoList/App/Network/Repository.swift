//
//  Repository.swift
//  ToDoList
//
//  Created by Diggo Silva on 28/02/25.
//

import Foundation

protocol RepositoryProtocol {
    func getTasks() -> [TaskModel]
    func saveTask(_ task: TaskModel, completion: @escaping(Result<String, AddTaskError>) -> Void)
    func updateTaskModel(task: TaskModel)
}

class Repository: RepositoryProtocol {
    private let userDefaults = UserDefaults.standard
    private let taskKey = "taskKey"
    
    func getTasks() -> [TaskModel] {
        if let data = userDefaults.data(forKey: taskKey) {
            if let decodedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) {
                return decodedTasks
            }
        }
        return []
    }
    
    func saveTask(_ task: TaskModel, completion: @escaping(Result<String, AddTaskError>) -> Void) {
        var savedTasks = getTasks()
        savedTasks.append(task)
        
        if let encodedTask = try? JSONEncoder().encode(savedTasks) {
            userDefaults.set(encodedTask, forKey: taskKey)
            completion(.success(task.title))
            return
        }
        completion(.failure(.genericError))
    }
    
    func updateTaskModel(task: TaskModel) {
        let savedTasks = getTasks()
        
        if let taskIndex = savedTasks.firstIndex(where: { $0.id == task.id }) {
            savedTasks[taskIndex].isCompleted = task.isCompleted
            
            let encodedTask = try! JSONEncoder().encode(savedTasks) 
                userDefaults.set(encodedTask, forKey: taskKey)
        }
    }
}
