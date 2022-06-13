//
//  ViewController.swift
//  testBet
//
//  Created by Тоха on 12.06.2022.
//

import UIKit

protocol BaseController: AnyObject {
    var presenter: BasePresenter? { get set }
}

class AutoViewController: UIViewController, PresenterOutput, BaseController {
    
    //MARK: - Properties
    
    private let mainTableView = UITableView()
    private let activitiView = UIActivityIndicatorView()
    var presenter: BasePresenter?
    private var brands: [MyBrand] = [] {
        didSet {
            mainTableView.reloadData()
            if brands.isEmpty {
                activitiView.isHidden = false
            } else {
                activitiView.isHidden = true
            }
        }
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
        registerCellAndHeader()
        setUpActivitiView()
        presenter?.performData()
    }
    
    override func viewWillLayoutSubviews() {
        setUpTableViewLayout()
        setUpConstraints()
    }

    //MARK: - Setups
    
    private func setUpTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.clipsToBounds = true
        
        mainTableView.sectionHeaderHeight = 70
        mainTableView.sectionHeaderTopPadding = 5
        
        mainTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        mainTableView.rowHeight = 50
        view.addSubview(mainTableView)
    }
    
    private func setUpActivitiView() {
        activitiView.translatesAutoresizingMaskIntoConstraints = false
        activitiView.style = .large
        activitiView.startAnimating()
        view.addSubview(activitiView)
    }
    
    private func registerCellAndHeader() {
        mainTableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.cellId)
        mainTableView.register(BrandTableHeaderView.self, forHeaderFooterViewReuseIdentifier: BrandTableHeaderView.headerId)
    }
    
    
    //MARK: - Layuot
    
    private func setUpTableViewLayout() {
        mainTableView.layer.cornerRadius = 16
        mainTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        mainTableView.separatorColor = .clear
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                mainTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
                mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                activitiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activitiView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    //MARK: - Actions
    func setNewData(_ data: [MyBrand]) {
        brands = data
    }

}

//MARK: - Extensions
extension AutoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brands[section].cars.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BrandTableHeaderView.headerId) as? BrandTableHeaderView
        let brand = brands[section]
        header?.configureHeader(with: brand)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.cellId) as? CarTableViewCell else {
            print("cant create cell")
            return UITableViewCell()
        }
        let car = brands[indexPath.section].cars[indexPath.row]
        cell.configureRow(with: car)
        
        if indexPath.row == brands[indexPath.section].cars.count-1 {
            cell.makeCorners()
        } else {
            cell.disableCorners()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return brands.count
    }
    
}

