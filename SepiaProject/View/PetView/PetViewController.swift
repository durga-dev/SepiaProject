//
//  PetViewController.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import UIKit

class PetViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var petViewModel: PetViewModelProtocol?
    
    enum StringConstant: String {
        case petTableViewCell = "PetTableViewCell"
        case main = "Main"
        case petDetailsViewController = "PetDetailsViewController"
    }
    
    var petList: [PetProtocol]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
    }

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: StringConstant.petTableViewCell.rawValue, bundle: nil),
            forCellReuseIdentifier: StringConstant.petTableViewCell.rawValue
        )
    }
    
    private func setupViewModel() {
        petViewModel = PetViewModel()
        petViewModel?.updatePetList = { [weak self] petList in
            self?.petList = petList
        }
        petViewModel?.viewDidLoad()
    }
}
