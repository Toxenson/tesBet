//
//  BrandTableHeaderView.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import UIKit

class BrandTableHeaderView: UITableViewHeaderFooterView {
    //MARK: - Properties
    
    static let headerId = String(describing: BrandTableHeaderView.self)
    private let brandLabel = UILabel()
    private let founderLabel = UILabel()
    private let dateLabel = UILabel()
    
    //MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layuotHeader()
        activateConstraints()
    }
    //MARK: - SetUp
    
    private func setUpLabels() {
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.textAlignment = .center
        brandLabel.font = UIFont.boldSystemFont(ofSize: 20)
        brandLabel.textColor = .white
        
        founderLabel.translatesAutoresizingMaskIntoConstraints = false
        founderLabel.textAlignment = .left
        founderLabel.font = UIFont.boldSystemFont(ofSize: 14)
        founderLabel.textColor = .white
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.boldSystemFont(ofSize: 10)
        dateLabel.textColor = .white
        
        contentView.addSubview(brandLabel)
        contentView.addSubview(founderLabel)
        contentView.addSubview(dateLabel)
    }
    //MARK: - Layuot
    
    private func layuotHeader() {
        contentView.layer.cornerRadius = 16
        contentView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                brandLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
                brandLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                founderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                founderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                
                dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                
            ]
        )
        
    }
    //MARK: - Configure
    
    func configureHeader(with brand: MyBrand) {
        brandLabel.text = brand.brandName
        founderLabel.text = brand.founderNames.first
        dateLabel.text = brand.foundationDate
    }
}
