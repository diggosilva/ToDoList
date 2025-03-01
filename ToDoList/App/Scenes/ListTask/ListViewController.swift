//
//  ListViewController.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import UIKit

class ListViewController: UIViewController {

    private var listView: ListView!
    private var viewModel: ListViewModel!
    
    init(listView: ListView = ListView(), viewModel: ListViewModel = ListViewModel()) {
        self.listView = listView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        super.loadView()
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadTasks()
        print("DEBUG: Você tem \(viewModel.getAllTasks()) tarefas na sua lista.")
        listView.tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        title = "Lista 📝"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector (addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector (editTapped))
    }
    
    private func configureDelegatesAndDataSources() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        viewModel.delegate = self
    }
    
    @objc private func editTapped() {
        print("DEBUG: Clicou no edit")
    }
    
    @objc private func addTapped() {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        cell.configure(task: viewModel.cellForRow(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.updateTaskCompletion(at: indexPath)
    }
}

extension ListViewController: ListViewModelDelegate {
    func reloadTable() {
        listView.tableView.reloadData()
    }
}
