//
//  ConfigViewModel.swift
//  sepia
//
//  Created by User on 17/12/22.
//

import Foundation

public protocol ConfigViewModelProtocol: BaseViewModelProtocol {
    var updateWorkingHours: ((WorkingTimeProtocol?) -> Void)? { get set }
}

final class ConfigViewModel: ConfigViewModelProtocol {
    
    var updateWorkingHours: ((WorkingTimeProtocol?) -> Void)?
    
    func viewDidLoad() {
        getWorkingHoursConfig()
    }
    
    func getWorkingHoursConfig() {
        APIHelper.shared.getWorkingHourConfig { workingHourConfig in
            updateWorkingHours?(workingHourConfig)
        }
    }
}
