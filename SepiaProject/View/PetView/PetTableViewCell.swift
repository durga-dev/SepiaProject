//
//  PetTableViewCell.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    
    var petData: PetProtocol? {
        didSet {
            petNameLabel.text = petData?.title ?? ""
            createdAtLabel.text = petData?.dateAdded ?? ""
            if let imageURL = petData?.imageUrl {
                petImageView.loadImage(from: imageURL)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        petNameLabel.text = ""
        petNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        createdAtLabel.text = ""
        createdAtLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }

}
