//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import Foundation

// MARK: - ListViewModelProtocol
protocol ListViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> TaskModel
    func updateTaskCompletion(at indexPath: IndexPath)
    func loadTasks()
    func saveTasksOrder()
    var tasks: [TaskModel] { get set }
    var delegate: ListViewModelDelegate? { get set }
}

// MARK: - ListViewModelDelegate
protocol ListViewModelDelegate: AnyObject {
    func reloadTable()
}

class ListViewModel: ListViewModelProtocol {
    
    // MARK: - Properties
    var tasks: [TaskModel] = []
    private let repository: RepositoryProtocol
    weak var delegate: ListViewModelDelegate?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    // MARK: - Methods TableView
    func numberOfRowsInSection() -> Int {
        return tasks.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> TaskModel {
        return tasks[indexPath.row]
    }
    
    // MARK: - Methods Repository
    func addTask(title: String, completion: @escaping (Result<String, AddTaskError>) -> Void) {
        repository.saveTask(TaskModel(title: title)) { result in
            switch result {
            case .success(_):
                self.tasks.append(TaskModel(title: title))
                completion(.success(title))
            case .failure(_):
                completion(.failure(.genericError))
            }
        }
    }
    
    func updateTaskCompletion(at indexPath: IndexPath) {
        let taskModel = tasks[indexPath.row]
        taskModel.isCompleted.toggle()
        repository.updateTaskModel(task: taskModel)
        delegate?.reloadTable()
    }
    
    func loadTasks() {
        tasks = repository.getTasks()
    }
    
    func saveTasksOrder() {
        repository.saveTasks(tasks)
    }
}
