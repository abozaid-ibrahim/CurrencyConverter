//
//  Logger.swift
//  CurrencyConverter
//
//  Created by Abuzeid on 1/1/20.
//  Copyright © 2020 Abuzeid. All rights reserved.
//
import Foundation
enum LoggingLevels {
    case info, error
    var value: String {
        switch self {
        case .info:
            return "INFO>"
        case .error:
            return "ERROR>"
        }
    }
}

func log(_ level: LoggingLevels, _ value: Any?) {
    #if DEBUG
        if let _value = value {
            print("->\(level.value) \(_value)")
        } else {
            print("->\(level.value) nil")
        }
    #endif
}
