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
            userDefaults.set(savedTasks, forKey: taskKey)
            completion(.success(task.title))
            return
        }
        completion(.failure(.genericError))
    }
}