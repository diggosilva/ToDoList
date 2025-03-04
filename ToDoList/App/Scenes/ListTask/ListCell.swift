//
//  ListCell.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import UIKit

class ListCell: UITableViewCell {
    
    // MARK: - Properties
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
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var timeStampLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        return lbl
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configuration
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
        timeStampLabel.text = formatDate(task.creationDate)
    }
    
    // MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.label
        ]
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: normalAttributes)
    }
    
    // MARK: - Private Methods
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    private func setHierarchy() {
        contentView.addSubviews(completedImage, titleLabel, timeStampLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            completedImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            completedImage.widthAnchor.constraint(equalToConstant: 24),
            completedImage.heightAnchor.constraint(equalTo: completedImage.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding / 2),
            titleLabel.leadingAnchor.constraint(equalTo: completedImage.trailingAnchor, constant: padding / 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            timeStampLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            timeStampLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeStampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
        ])
    }
}
