class ListViewModel: ListViewModelProtocol {
    var tasks: [TaskModel] = [
        TaskModel(id: UUID().uuidString, title: "Estudar Swift"),
        TaskModel(id: UUID().uuidString, title: "Estudar UserDefaults"),
        TaskModel(id: UUID().uuidString, title: "Estudar Coordinator"),
    ]
    
    func numberOfRowsInSection() -> Int {
        return tasks.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> TaskModel {
        return tasks[indexPath.row]
    }
}