class ListCell: UITableViewCell {
    static let identifier: String = "ListCell"
    
    lazy var completedImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleToggleCompleted))
        img.addGestureRecognizer(tapGesture)
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Title here"
        return lbl
    }()
    
    var isCompleted: Bool = false {
        didSet {
            completedImage.image = UIImage(systemName: isCompleted ? "checkmark.circle" : "circle")?
                .withTintColor(isCompleted ? .systemGreen : .systemRed, renderingMode: .alwaysOriginal)
            
            if isCompleted {
                let attribute: [NSAttributedString.Key: Any] = [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.systemGray,
                    .font: UIFont.italicSystemFont(ofSize: 17),
                    .foregroundColor: UIColor.systemGray
                ]
                titleLabel.attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: attribute)
            } else {
                let normalAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 17),
                    .foregroundColor: UIColor.label
                ]
                titleLabel.attributedText = NSAttributedString(string: titleLabel.text ?? "", attributes: normalAttributes)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func handleToggleCompleted() {
        isCompleted.toggle()
        if isCompleted {
            print("Está Completa")
        } else {
            print("Não Está Completa")
        }
    }
    
    func configure(task: TaskModel) {
        titleLabel.text = task.title
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