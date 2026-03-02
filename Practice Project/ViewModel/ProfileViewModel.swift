//
//  ProfileViewModel.swift
//  Practice Project
//
//  Created by Tharik Batcha on 27/02/26.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    var firstName: String = ""
    var lastName: String = ""
    var userName: String = ""
    var email: String = ""
    var phone: String = ""
    
    var isFormValid: Bool {
        return !firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
               !lastName.trimmingCharacters(in: .whitespaces).isEmpty &&
               !userName.trimmingCharacters(in: .whitespaces).isEmpty &&
               !email.trimmingCharacters(in: .whitespaces).isEmpty &&
               !phone.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
