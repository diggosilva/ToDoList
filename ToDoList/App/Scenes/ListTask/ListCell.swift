//
//  ListCell.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import UIKit

class ListCell: UITableViewCell {
    static let identifier: String = "ListCell"
    
    lazy var completedImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Title here"
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(task: TaskModel) {
        titleLabel.text = task.title
        
        completedImage.image = UIImage(systemName: task.isCompleted ? "checkmark.circle" : "circle")?
            .withTintColor(task.isCompleted ? .systemGreen : .systemRed, renderingMode: .alwaysOriginal)
        
        if task.isCompleted {
            let attribute: [NSAttributedString.Key: Any] = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: UIColor.systemGray,
                .font: UIFont.italicSystemFont(ofSize: 17),
                .foregroundColor: UIColor.systemGray
            ]
            titleLabel.attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: attribute)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.label
        ]
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: normalAttributes)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubviews(completedImage, titleLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            completedImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            completedImage.widthAnchor.constraint(equalToConstant: 24),
            completedImage.heightAnchor.constraint(equalTo: completedImage.widthAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: completedImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: completedImage.trailingAnchor, constant: padding / 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
    }
}
