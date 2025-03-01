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

protocol AddViewModelProtocol {
    func addTask(title: String, completion: @escaping(Result<String, AddTaskError>) -> Void)
}

class AddViewModel: AddViewModelProtocol {
    var tasks: [TaskModel] = []
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    private func validateTask(title: String, completion: @escaping(Result<String, AddTaskError>) -> Void) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            title.isEmpty ? completion(.failure(.emptyTask)) : completion(.failure(.whiteSpaceTask))
            return
        }
        completion(.success(title))
    }
    
    func addTask(title: String, completion: @escaping(Result<String, AddTaskError>) -> Void) {
        // Validar Task
        validateTask(title: title) { result in
            switch result {
            case .success(let validTitle):
                let newTask = TaskModel(title: validTitle)
                self.repository.saveTask(newTask) { result in
                    switch result {
                    case .success(let title):
                        self.tasks.append(newTask)
                        self.loadTasks() // Atualiza a lista de tarefas após salvar
                        completion(.success(title))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadTasks() {
        tasks = repository.getTasks()
    }
}
