//
//  AddViewModel.swift
//  ToDoList
//
//  Created by Diggo Silva on 27/02/25.
//

import Foundation

enum AddTaskError: String, Error {
    case emptyTask = "O campo de tarefa não pode estar vazio."
    case whiteSpaceTask = "O campo de tarefa não pode conter apenas espaços em branco."
    case genericError = "Ocorreu um erro ao tentar salvar a tarefa."
    
    var localizedDescription: String {
        return self.rawValue
    }
}

class AddViewModel {
    var tasks: [TaskModel] = []
    
    func validateTask(title: String, completion: @escaping(Result<String, AddTaskError>) -> Void) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            title.isEmpty ? completion(.failure(.emptyTask)) : completion(.failure(.whiteSpaceTask))
            return
        }
        completion(.success(title))
    }
    
    func addTask(title: String, completion: @escaping(Result<String, AddTaskError>) -> Void) {
        
    }
    
    func loadTasks() {
        
    }
}
