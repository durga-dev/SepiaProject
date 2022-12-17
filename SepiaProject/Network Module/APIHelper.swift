//
//  APIHelper.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import Foundation

public class APIHelper {
    private init() {
        NSLog("APIHelper Initialized")
    }
    
    private enum StringContants: String {
        case petJSON = "pets_list"
        case configJSON = "config"
        case JSON = "json"
    }
    
    public static let shared = APIHelper()
    
    public func getPetListService(completion: ([PetProtocol]) -> Void) {
        guard let petJSONFile = Bundle.main.path(
            forResource: StringContants.petJSON.rawValue,
            ofType: StringContants.JSON.rawValue
        ) else {
            return completion([])
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = try String(contentsOfFile: petJSONFile).data(using: .utf8) {
                let jsonData = try jsonDecoder.decode(PetModel.self, from: data)
                completion(
                    jsonData.pets?.map({ PetModelMapper(pet: $0) }) ?? []
                )
            } else {
                completion([])
            }
        } catch {
            completion([])
        }
    }
    
    public func getWorkingHourConfig(completion: (WorkingTimeProtocol?) -> Void) {
        guard let petJSONFile = Bundle.main.path(
            forResource: StringContants.configJSON.rawValue,
            ofType: StringContants.JSON.rawValue
        ) else {
            return completion(nil)
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = try String(contentsOfFile: petJSONFile).data(using: .utf8) {
                let jsonData = try jsonDecoder.decode(WorkingTimeConfigModel.self, from: data)
                let workingTime = WorkingTimeModel(workingTimeConfig: jsonData)
                completion(workingTime)
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }
}
