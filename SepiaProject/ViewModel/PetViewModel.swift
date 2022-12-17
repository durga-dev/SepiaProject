//
//  PetViewModel.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import Foundation


public protocol PetViewModelProtocol: BaseViewModelProtocol {
    var updatePetList: (([PetProtocol]) -> Void)? { get set }
}

public class PetViewModel: PetViewModelProtocol {
    public var updatePetList: (([PetProtocol]) -> Void)?
    
    public func viewDidLoad() {
        getPetList()
    }
    
    private func getPetList() {
        APIHelper.shared.getPetListService { [weak self] petData in
            self?.updatePetList?(petData)
        }
    }
}
