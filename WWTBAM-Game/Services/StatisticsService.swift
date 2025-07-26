//
//  StatisticsService.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//

import Foundation

struct SavedData: Codable {
    
    var date: Date
    var amount: Int
}


class StatisticsService {
    
    static let shared = StatisticsService()
    
    private let defaults = UserDefaults.standard
    
    private var data: [SavedData] {
        didSet {
            saveData()
        }
    }
    
    init() {
        if let savedData = defaults.object(forKey: "SavedData") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([SavedData].self, from: savedData) {
                self.data = loadedData
                return
            }
        }
        self.data = []
    }

    // переделать под номер вопроса сопоставляя сумму с номером вопроса

    func saveData(date: Date, amount: Int?) {
        data.append(SavedData(date: date, amount: amount ?? 0))
    }
    
    func setAmountForLastDate(_ amount: Int) {
        data[data.count - 1].amount = amount
    }
    
    func loadData() -> [SavedData] {
        return data
    }
    
    
    func getBestAmount() -> String {
        return ""
    }
    
    private func amountStringToInt(amount: String) -> Int {
        
        return 0
    }
    
    private func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            defaults.set(encoded, forKey: "SavedData")
        }
    }
    
    
}
