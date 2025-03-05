//
//  AddViewController.swift
//  ToDoList
//
//  Created by Diggo Silva on 27/02/25.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: - Properties
    private let addView: AddView!
    private let viewModel: AddViewModelProtocol!
    
    // MARK: - Initializer
    init(addView: AddView = AddView(), viewModel: AddViewModelProtocol = AddViewModel()) {
        self.addView = addView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = addView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Configuration
    private func configureNavigationBar() {
        title = "Adicionar Tarefa ✒️"
    }
    
    private func configureDelegatesAndDataSources() {
        addView.delegate = self
    }
}

// MARK: - AddViewDelegate
extension AddViewController: AddViewDelegate {
    func addViewDidSave() {
        guard let taskTitle = addView.taskTextfield.text else { return }
        viewModel.addTask(title: taskTitle) { result in
            switch result {
            case .success(_):
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(let error):
                self.showAlertError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Alerts
    func showAlertError(message: String) {
        let alert = UIAlertController(title: "Ops... algo deu errado!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            self.addView.taskTextfield.text = ""
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
