//
//  ToDoListTestsListViewModel.swift
//  ToDoListTests
//
//  Created by Diggo Silva on 05/03/25.
//

import XCTest
@testable import ToDoList

class MockSuccessList: RepositoryProtocol {
    var tasks: [TaskModel] = [TaskModel(title: "Test 1"), TaskModel(title: "Test 2")]
    
    func getTasks() -> [TaskModel] {
        return tasks.count > 0 ? tasks : []
    }
    
    func saveTask(_ task: TaskModel, completion: @escaping (Result<String, AddTaskError>) -> Void) {
        tasks.append(task)
        completion(.success("Tarefa adicionada com sucesso!"))
    }
    
    func updateTaskModel(task: TaskModel) {
        let index = tasks.firstIndex(where: { $0.id == task.id })
        if let index = index {
            tasks[index] = task
            saveTasks(tasks)
        }
    }
    
    func saveTasks(_ tasks: [TaskModel]) {
        self.tasks = tasks
    }
}

class MockFailureList: RepositoryProtocol {
    var tasks: [TaskModel] = [TaskModel(title: "Test 1"), TaskModel(title: "Test 2")]
    
    func getTasks() -> [TaskModel] {
        return tasks.count > 0 ? tasks : []
    }
    
    func saveTask(_ task: TaskModel, completion: @escaping (Result<String, AddTaskError>) -> Void) {
        tasks.append(task)
        completion(.failure(AddTaskError.genericError))
    }
    
    func updateTaskModel(task: TaskModel) {
        let index = tasks.firstIndex(where: { $0.id == task.id })
        if let index = index {
            tasks[index] = task
            saveTasks(tasks)
        }
    }
    
    func saveTasks(_ tasks: [TaskModel]) {
        self.tasks = tasks
    }
}

final class ToDoListTestsListViewModel: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testWhenGetTasksFromRepositoryReturnsEmptyArrayThenNumberOfRowsIsZero() {
        let repository: RepositoryProtocol = MockSuccessList()
        let sut: ListViewModel = ListViewModel(repository: repository)
        let numberOfRows = sut.numberOfRowsInSection()
        XCTAssertEqual(numberOfRows, 0)
    }
    
    func testWhenGetTasksFromRepositoryReturnsNonEmptyArrayThenNumberOfRowsIsEqualToTasksCount() {
        let repository: RepositoryProtocol = MockSuccessList()
        let sut: ListViewModel = ListViewModel(repository: repository)
        
        sut.loadTasks()
        
        let numberOfRows = sut.numberOfRowsInSection()
        XCTAssertEqual(numberOfRows, 2)
    }
    
    func testWhenSaveTask() {
        let repository: RepositoryProtocol = MockSuccessList()
        let sut: ListViewModel = ListViewModel(repository: repository)
        
        sut.loadTasks()
        sut.addTask(title: "Test 3") { result in
            switch result {
            case .success(_):
                let newTask = sut.cellForRow(at: IndexPath(row: 2, section: 0))
                XCTAssertEqual(newTask.title, "Test 3")
            case .failure(let failure):
                XCTFail("Erro ao salvar a tarefa: \(failure)")
            }
        }
    }
    
    func testWhenUpdateTask() {
        let repository: RepositoryProtocol = MockSuccessList()
        let sut: ListViewModel = ListViewModel(repository: repository)
        
        sut.loadTasks()
        sut.updateTaskCompletion(at: IndexPath(row: 1, section: 0))
        sut.saveTasksOrder()
        
        let updatedTask = sut.cellForRow(at: IndexPath(row: 1, section: 0))
        XCTAssertTrue(updatedTask.isCompleted)
    }
    
    func testWhenSaveTaskFailure() {
        let repository: RepositoryProtocol = MockFailureList()
        let sut: ListViewModel = ListViewModel(repository: repository)
        
        sut.loadTasks()
        sut.addTask(title: "Test 3") { result in
            switch result {
            case .success(_):
                XCTFail("Esperado falha, mas a tarefa foi salva com sucesso.")
            case .failure(let error):
                XCTAssertEqual(error, AddTaskError.genericError, "Erro esperado não ocorreu")
            }
        }
    }

    override func tearDown() {
        super.tearDown()
    }
}
