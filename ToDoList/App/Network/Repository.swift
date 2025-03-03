//
//  Repository.swift
//  ToDoList
//
//  Created by Diggo Silva on 28/02/25.
//

import Foundation

// MARK: - RepositoryProtocol
protocol RepositoryProtocol {
    func getTasks() -> [TaskModel]
    func saveTask(_ task: TaskModel, completion: @escaping(Result<String, AddTaskError>) -> Void)
    func updateTaskModel(task: TaskModel)
    func saveTasks(_ tasks: [TaskModel])
}

class Repository: RepositoryProtocol {
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    private let taskKey = "taskKey"
    
    // MARK: - Public Methods
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
    
    func saveTasks(_ tasks: [TaskModel]) {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            userDefaults.set(encodedTasks, forKey: taskKey)
        }
    }
}
