//
//  WorkingHourConfigurationTest.swift
//  sepiaTests
//
//  Created by User on 17/12/22.
//

import XCTest
@testable import SepiaProject

final class WorkingHourConfigurationTest: XCTestCase {
    
    func testIsValidServiceTimeWithValidConfigResultTrue() {
        let workingTimeConfig = WorkingTimeConfigModel(
            settings: Settings(
                workHours: "M-F 9:00 - 18:00"
            )
        )
        let workingTime = WorkingTimeModel(workingTimeConfig: workingTimeConfig)
        let currentDate = getDate(
            from: "13-12-2022 09:32 AM",
            format: "dd-MM-yyyy hh:mm a"
        )
        let result = workingTime.isValidServiceTime(for: currentDate ?? Date())
        XCTAssertTrue(result == true)
    }
    
    func testIsValidServiceTimeWithInvalidDayResultFalse() {
        let workingTimeConfig = WorkingTimeConfigModel(
            settings: Settings(
                workHours: "M-F 9:00 - 18:00"
            )
        )
        let workingTime = WorkingTimeModel(workingTimeConfig: workingTimeConfig)
        let currentDate = getDate(
            from: "18-12-2022 09:32 AM",
            format: "dd-MM-yyyy hh:mm a"
        )
        let result = workingTime.isValidServiceTime(for: currentDate ?? Date())
        XCTAssertTrue(result == false)
    }
    
    func testIsValidServiceTimeWithInvalidTimeResultFalse() {
        let workingTimeConfig = WorkingTimeConfigModel(
            settings: Settings(
                workHours: "M-F 9:00 - 18:00"
            )
        )
        let workingTime = WorkingTimeModel(workingTimeConfig: workingTimeConfig)
        let currentDate = getDate(
            from: "14-12-2022 09:32 PM",
            format: "dd-MM-yyyy hh:mm a"
        )
        let result = workingTime.isValidServiceTime(for: currentDate ?? Date())
        XCTAssertTrue(result == false)
    }
    
    func testIsValidServiceTimeWithInvalidDayTimeResultFalse() {
        let workingTimeConfig = WorkingTimeConfigModel(
            settings: Settings(
                workHours: "M-F 9:00 - 18:00"
            )
        )
        let workingTime = WorkingTimeModel(workingTimeConfig: workingTimeConfig)
        let currentDate = getDate(
            from: "18-12-2022 09:32 PM",
            format: "dd-MM-yyyy hh:mm a"
        )
        let result = workingTime.isValidServiceTime(for: currentDate ?? Date())
        XCTAssertTrue(result == false)
    }
    
    func testIsValidServiceTimeWithNoConfigResultFalse() {
        let workingTimeConfig = WorkingTimeConfigModel(
            settings: Settings(
                workHours: nil
            )
        )
        let workingTime = WorkingTimeModel(workingTimeConfig: workingTimeConfig)
        let currentDate = getDate(
            from: "18-12-2022 09:32 AM",
            format: "dd-MM-yyyy hh:mm a"
        )
        let result = workingTime.isValidServiceTime(for: currentDate ?? Date())
        XCTAssertTrue(result == false)
    }
    
    
    private func getDate(
        from string: String,
        format: String
    ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }

}
