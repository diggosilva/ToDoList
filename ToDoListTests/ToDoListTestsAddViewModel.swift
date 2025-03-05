//
//  ToDoListTestsAddViewModel.swift
//  ToDoListTests
//
//  Created by Diggo Silva on 05/03/25.
//

import XCTest
@testable import ToDoList

class MockSuccessAdd: RepositoryProtocol {
    func getTasks() -> [TaskModel] {
        return []
    }
    
    func saveTask(_ task: TaskModel, completion: @escaping (Result<String, AddTaskError>) -> Void) {
        completion(.success("Tarefa adicionada com sucesso!"))
    }
    
    func updateTaskModel(task: TaskModel) {}
    
    func saveTasks(_ tasks: [TaskModel]) {}
}

class MockFailureAdd: RepositoryProtocol {
    func getTasks() -> [TaskModel] {
        return []
    }
    
    func saveTask(_ task: TaskModel, completion: @escaping (Result<String, AddTaskError>) -> Void) {
        let error = AddTaskError.genericError
        completion(.failure(error))
    }
    
    func updateTaskModel(task: TaskModel) {}
    
    func saveTasks(_ tasks: [TaskModel]) {}
}

final class ToDoListTestsAddViewModel: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testWhenSuccess() {
        let sut: AddViewModel = AddViewModel(repository: MockSuccessAdd())
        
        let tasks = [TaskModel(title: "Estudar Swift"), TaskModel(title: "Estudar XCTest")]
        XCTAssertEqual(tasks.count, 2)
        
        let emptyTitle = TaskModel(title: "")
        XCTAssertTrue(emptyTitle.title.isEmpty)
        
        let emptySpace = TaskModel(title: " ")
        XCTAssertTrue(emptySpace.title.trimmingCharacters(in: .whitespaces).isEmpty)
        
        sut.addTask(title: "Test 1") { result in
            switch result {
            case .success(let message):
                XCTAssertEqual(message, "Tarefa adicionada com sucesso!")
            case .failure:
                XCTFail("Esperado sucesso, mas falhou!")
            }
        }
    }
    
    func testWhenFailure() {
        let sut: AddViewModel = AddViewModel(repository: MockFailureAdd())
        
        sut.addTask(title: "Test 2") { result in
            switch result {
            case .success(let message):
                XCTFail("Esperado falha, mas obteve sucesso: \(message)")
            case .failure(let error):
                XCTAssertEqual(error, AddTaskError.genericError)
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
