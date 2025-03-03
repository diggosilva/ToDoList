//
//  AddView.swift
//  ToDoList
//
//  Created by Diggo Silva on 27/02/25.
//

import UIKit

// MARK: - AddViewDelegate
protocol AddViewDelegate: AnyObject {
    func addViewDidSave()
}

class AddView: UIView {
    
    // MARK: - Properties
    lazy var taskTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nova tarefa aqui..."
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var addButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Salvar"
        
        let btn = UIButton(configuration: configuration)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector (saveTapped), for: .touchUpInside)
        return btn
    }()
    
    weak var delegate: AddViewDelegate?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Actions
    @objc func saveTapped() {
        delegate?.addViewDidSave()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews(taskTextfield, addButton)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            taskTextfield.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            taskTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            taskTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            addButton.topAnchor.constraint(equalTo: taskTextfield.bottomAnchor, constant: padding),
            addButton.leadingAnchor.constraint(equalTo: taskTextfield.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: taskTextfield.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
