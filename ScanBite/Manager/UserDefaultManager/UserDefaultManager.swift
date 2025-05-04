//
//  UserDefaultEnum.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import Foundation
import Combine
import SwiftUI

enum UserDefaultEnum: String {

    case userDetails
    case lastCheckedDate
    case dailyMacroData
    
}

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    let userDefaults : UserDefaults = UserDefaults.standard

    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {

        if shared.get() != nil {
            
            return true
        }
        return false
    }
    
    func set(user: User?) {
        if let User = user{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(User) {
                userDefaults.set(encoded, forKey: UserDefaultEnum.userDetails.rawValue)
            }
        }
    }

    func get() -> User? {
   
        if let userData: Data =  userDefaults.object(forKey: UserDefaultEnum.userDetails.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
            debugPrint("User Decoder Error")
        }
        debugPrint("User Not Found in UsersDefaults")
        return nil
    }
    
    func set(updateDailyMacroRecord: [DailyMacrosData]?) {
        if let data = updateDailyMacroRecord{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(data) {
                userDefaults.set(encoded, forKey: UserDefaultEnum.dailyMacroData.rawValue)
            }
        }
    }
    
    func getAllDailyMacroData() -> [DailyMacrosData]? {
   
        if let data: Data =  userDefaults.object(forKey: UserDefaultEnum.dailyMacroData.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode([DailyMacrosData].self, from: data) {
                return data
            }
            debugPrint("User Decoder Error")
        }
        debugPrint("User Not Found in UsersDefaults")
        return nil
    }
    
    func getDailyMacroData(for date: Date) -> User {
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date)
        
        var user = self.get() ?? User()
        user.loggedFats = 0
        user.loggedCarbs = 0
        user.loggedProtein = 0
        user.loggedCaloris = 0
        user.loggedMeals = [Meal]()
        
        return self.getAllDailyMacroData()?
            .first { calendar.startOfDay(for: $0.date) == targetDate }?
            .data ?? user
    }

    func removeUser() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaultManager.Authenticated.send(false)
    }
    
    func logMacors(meal: Meal){
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var user = self.get() ?? User()
        user.loggedCaloris += meal.calories?.extractDouble ?? 0.0
        user.loggedCarbs += meal.carbs?.extractDouble ?? 0.0
        user.loggedFats += meal.fat?.extractDouble ?? 0.0
        user.loggedProtein += meal.protein?.extractDouble ?? 0.0
        user.loggedMeals.append(meal)
        self.set(user: user)
        
        var newData = self.getAllDailyMacroData() ?? [DailyMacrosData]()
        
        if let index = newData.firstIndex(where: { calendar.startOfDay(for: $0.date) == today }) {
            newData[index].data = user
        } else {
            let newEntity = DailyMacrosData(date: today, data: user)
            newData.append(newEntity)
        }
        self.set(updateDailyMacroRecord: newData)
        
    }
    
    func resetIfDateChanged() {
        let currentDate = Calendar.current.startOfDay(for: Date()) // Today's date at midnight
        let lastSavedDate = UserDefaults.standard.object(forKey: UserDefaultEnum.lastCheckedDate.rawValue) as? Date ?? Date.distantPast
        
        if !Calendar.current.isDate(currentDate, inSameDayAs: lastSavedDate) {
            
            UserDefaults.standard.set(currentDate, forKey:  UserDefaultEnum.lastCheckedDate.rawValue)
            
            var user = self.get() ?? User()
            user.loggedFats = 0
            user.loggedCarbs = 0
            user.loggedProtein = 0
            user.loggedCaloris = 0
            user.loggedMeals = [Meal]()
            self.set(user: user)
        }
    }

}


