//
//  UserModel.swift
//  SwiftHire
//
//  Created by HS on 16/03/24.
//

import Foundation

class Users: Codable {
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fname = try container.decode(String.self, forKey: .fname)
        lname = try container.decode(String.self, forKey: .lname)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        dob = try container.decode(Date.self, forKey: .dob)
    }
    
    // Getter methods for accessing private properties
    
    func getFirstName() -> String {
        print(fname)
        return self.fname
    }
    
    func getLastName() -> String {
        print(lname)
        return self.lname
    }
    
    func getEmail() -> String {
        print(email)
        return self.email
    }
    
    func getPassword() -> String {
        print(password)
        return self.password
    }
    
    func getDateOfBirth() -> Date {
        print(dob)
        return self.dob
    }
}
