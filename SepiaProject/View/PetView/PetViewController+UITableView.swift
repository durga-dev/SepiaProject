//
//  PetViewController+UITableView.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import UIKit

extension PetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petList?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StringConstant.petTableViewCell.rawValue,
            for: indexPath
        ) as? PetTableViewCell else {
            return UITableViewCell()
        }
        
        cell.petData = petList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let petDetailsViewController = UIStoryboard(
            name: StringConstant.main.rawValue,
            bundle: nil
        ).instantiateViewController(
            withIdentifier: StringConstant.petDetailsViewController.rawValue
        ) as? PetDetailsViewController {
            petDetailsViewController.modalPresentationStyle = .fullScreen
            present(petDetailsViewController, animated: true)
            petDetailsViewController.onLoad?(petList?[indexPath.row])
        }
    }
}
