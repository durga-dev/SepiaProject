//
//  ConfigViewController.swift
//  sepia
//
//  Created by User on 17/12/22.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var configViewModel: ConfigViewModelProtocol?
    
    private enum WorkingStatus: String {
        case working
        case notWorking = "not-working"
    }
    
    private enum StringConstants: String {
        case workingMessage = "We are open now !!"
        case notWorkingMessage = "Service is not available right now. Please come once again between {start_day} to {end_day} and {start_time} to {end_time}. Sorry for the inconvenience !!"
        case main = "Main"
        case petViewController = "PetViewController"
        
        var value: String {
            rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        messageLabel.text = ""
        messageLabel.font = .systemFont(ofSize: 17, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = .zero
    }
    
    private func setupData() {
        configViewModel = ConfigViewModel()
        
        configViewModel?.updateWorkingHours = { [weak self] workingTimeConfig in
            self?.updateUI(workingTime: workingTimeConfig)
        }
        configViewModel?.viewDidLoad()
    }
    
    private func updateUI(workingTime: WorkingTimeProtocol?) {
        let workingStatus: WorkingStatus = (workingTime?.isServiceAvailable ?? false) ? .working: .notWorking
        imageView.image = UIImage(named: workingStatus.rawValue)
        switch workingStatus {
        case .working:
            messageLabel.text = StringConstants.workingMessage.value
            if let petListViewController = UIStoryboard(
                name: StringConstants.main.value,
                bundle: nil
            ).instantiateViewController(
                withIdentifier: StringConstants.petViewController.value
            ) as? PetViewController {
                petListViewController.modalPresentationStyle = .fullScreen
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                    self?.present(petListViewController, animated: true)
                }
            }
        case .notWorking:
            messageLabel.text = getNotWorkingMessage(workingTime: workingTime)
        }
    }
    
    private func getNotWorkingMessage(workingTime: WorkingTimeProtocol?) -> String {
        var notWorkingMessage = StringConstants.notWorkingMessage.value
        let notWorkingMessageVariables = [
            "{start_day}": workingTime?.startOfTheWeek ?? "",
            "{end_day}": workingTime?.endOfTheWeek ?? "",
            "{start_time}": workingTime?.startOfDay ?? "",
            "{end_time}": workingTime?.endOfDay ?? ""
        ]
        
        notWorkingMessageVariables.forEach { (key: String, value: String) in
            notWorkingMessage = notWorkingMessage.replacingOccurrences(of: key, with: value)
        }
        return notWorkingMessage
    }
}
