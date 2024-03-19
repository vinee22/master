//
//  AdminModel.swift
//  SwiftHire
//
//  Created by HS on 19/03/24.
//

import Foundation

class Admin: Codable {
    
    var cname : String
    var interviewtype : String
    var idate : Date
    var itime : Date
    
    init(cname: String = "", interviewtype: String = "", idate: Date = Date(), itime: Date = Date()) {
        self.cname = cname
        self.interviewtype = interviewtype
        self.idate = idate
        self.itime = itime
    }
    
    init(){
        self.cname = ""
        self.interviewtype = ""
        self.idate = Date()
        self.itime = Date()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cname = try container.decode(String.self, forKey: .cname)
        interviewtype = try container.decode(String.self, forKey: .interviewtype)
        idate = try container.decode(Date.self, forKey: .idate)
        itime = try container.decode(Date.self, forKey: .itime)
    }
    
    // Getter methods for accessing private properties
    
    func getCandidateName() -> String {
        print(cname)
        return self.cname
    }
    
    func getInterviewType() -> String {
        print(interviewtype)
        return self.interviewtype
    }
    
    func getInterviewDate() -> Date {
        print(idate)
        return self.idate
    }
    
    func getInterviewTime() -> Date {
        print(itime)
        return self.itime
    }
}
