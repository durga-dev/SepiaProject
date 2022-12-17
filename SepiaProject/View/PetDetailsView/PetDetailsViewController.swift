//
//  PetDetailsViewController.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController {

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petDetailsWebView: WKWebView!
    @IBOutlet weak var petImageView: UIImageView!
    
    private var petDetails: PetProtocol? {
        didSet {
            updateData()
        }
    }
    
    public var onLoad: ((PetProtocol?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }
    
    private func setupUI() {
        petNameLabel.text = ""
        petNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    private func setupData() {
        onLoad = { [weak self] data in
            self?.petDetails = data
        }
    }
    
    private func updateData() {
        guard let petDetails = petDetails else { return }
        petImageView.loadImage(from: petDetails.imageUrl ?? "")
        petNameLabel.text = petDetails.title
        
        if let contentURLString = petDetails.contentUrl,
           let url = URL(string: contentURLString) {
            let urlRequest = URLRequest(url: url)
            
            DispatchQueue.main.async { [weak self] in
                self?.petDetailsWebView.load(urlRequest)
            }
            
        }
        
    }
}
