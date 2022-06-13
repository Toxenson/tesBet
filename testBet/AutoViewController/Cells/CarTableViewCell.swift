//
//  CarTableViewCell.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    static let cellId = String(describing: CarTableViewCell.self)
    private let modelLabel = UILabel()
    private let dateLabel = UILabel()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layuotCell()
        activateConstraints()
    }
    //MARK: - SetUp
    
    private func setUpLabels() {
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.textAlignment = .left
        modelLabel.font = UIFont.boldSystemFont(ofSize: 16)
        modelLabel.textColor = .white
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.textColor = .white
        
        contentView.addSubview(modelLabel)
        contentView.addSubview(dateLabel)
    }
    //MARK: - Layuot
    
    private func layuotCell() {
        contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                modelLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                modelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                
                dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ]
        )
        
    }
    //MARK: - Configure
    
    func configureRow(with car: Car) {
        modelLabel.text = car.modelName
        dateLabel.text = car.releaseDate
    }
    
    func makeCorners() {
        contentView.layer.cornerRadius = 16
        contentView.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func disableCorners() {
        contentView.layer.cornerRadius = 0
    }

}
