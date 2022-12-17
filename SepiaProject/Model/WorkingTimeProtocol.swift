//
//  WorkingTimeProtocol.swift
//  sepia
//
//  Created by User on 17/12/22.
//

import Foundation

public protocol WorkingTimeProtocol {
    var startOfTheWeek: String? { get }
    var endOfTheWeek: String? { get }
    var startOfDay: String? { get }
    var endOfDay: String? { get }
    var isServiceAvailable: Bool? { get }
}

public struct WorkingTimeModel: WorkingTimeProtocol {
    public var startOfTheWeek: String? {
        startDay?.stringValue
    }
    
    public var endOfTheWeek: String? {
        endDay?.stringValue
    }
    
    public var startOfDay: String? {
        startTime
    }
    
    public var endOfDay: String? {
        endTime
    }
    
    public var isServiceAvailable: Bool? {
        isValidServiceTime(for: Date())
    }
    
    private let workingTimeConfig: WorkingTimeConfigModel
    private var startDay, endDay: WeekDayEnum?
    private var startTime, endTime: String?
    
    init(workingTimeConfig: WorkingTimeConfigModel) {
        self.workingTimeConfig = workingTimeConfig
        updateDayTimeComponents()
    }
    
    private mutating func updateDayTimeComponents() {
        guard var configDayTime = workingTimeConfig.settings?.workHours else { return }
        let replacableChacaters = [
            " ",
            "-"
        ]
        replacableChacaters.forEach { character in
            configDayTime = configDayTime.replacingOccurrences(of: character, with: "@")
        }
        let allDayTimeComponents = configDayTime.components(separatedBy: "@").filter({ $0.isEmpty == false })
        
        let dateFormatter = DateFormatter()
        for index in 0..<allDayTimeComponents.count {
            let dayTimeComponent = allDayTimeComponents[index]
            switch index {
            case 0, 1:
                if dayTimeComponent.count == 1 {
                    dateFormatter.dateFormat = "E"
                } else if dayTimeComponent.count == 3 {
                    dateFormatter.dateFormat = "EEE"
                } else {
                    dateFormatter.dateFormat = "EEEE"
                }
                if let date = dateFormatter.date(from: dayTimeComponent) {
                    if index == 0 {
                        startDay = WeekDayEnum(
                            rawValue: Calendar.current.component(.weekday, from: date)
                        )
                    } else if index == 1 {
                        endDay = WeekDayEnum(
                            rawValue: Calendar.current.component(.weekday, from: date)
                        )
                    }
                }
            case 2, 3:
                dateFormatter.dateFormat = "H:mm"
                if let date = dateFormatter.date(from: dayTimeComponent) {
                    dateFormatter.dateFormat = "hh:mm a"
                    if index == 2 {
                        startTime = dateFormatter.string(from: date)
                    } else if index == 3 {
                        endTime = dateFormatter.string(from: date)
                    }
                }
            default:
                break
            }
        }
    }
    
    func isValidServiceTime(for currentDate: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        let date = currentDate
        
        let today = WeekDayEnum(rawValue: Calendar.current.component(.weekday, from: date)) ?? .Sunday
        
        
        if today.rawValue < (startDay?.rawValue ?? 2) ||
            today.rawValue > (endDay?.rawValue ?? 6) {
            return false
        }
        
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        var finalTime = ""
        if let hour = timeComponents.hour,
           let minute = timeComponents.minute {
            finalTime = "\(hour):\(minute)"
        }
        
        if finalTime.isEmpty == false {
            dateFormatter.dateFormat = "H:mm"
            if let currentTime = dateFormatter.date(from: finalTime) {
                dateFormatter.dateFormat = "hh:mm a"
                if let startTime = dateFormatter.date(from: startOfDay ?? ""),
                let endTime = dateFormatter.date(from: endOfDay ?? ""),
                   currentTime >= startTime ,
                   currentTime <= endTime {
                    return true
                }
            }
        }
        return false
    }
}

public enum WeekDayEnum: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednessday
    case Thursday
    case Friday
    case Saturday
    
    var stringValue: String {
        String(describing: self)
    }
}
