//
//  UserModel.swift
//  SwiftHire
//
//  Created by HS on 16/03/24.
//

import Foundation

class Users {
    
    private var fname : String
    private var lname : String
    private var email : String
    private var password : String
    private var dob : Date
    
    init(fname: String, lname: String, email: String, password: String, dob: Date) {
        self.fname = fname
        self.lname = lname
        self.email = email
        self.password = password
        self.dob = dob
    }
    
    init(){
        self.fname = ""
        self.lname = ""
        self.email = ""
        self.password = ""
        self.dob = Date()
    }
    
    // Getter methods for accessing private properties
    
    func getFirstName() -> String {
        return self.fname
    }
    
    func getLastName() -> String {
        return self.lname
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getDateOfBirth() -> Date {
        return self.dob
    }
}
