//
//  Member.swift
//  pr_MemberList
//
//  Created by 김현목 on 8/8/24.
//

import Foundation
import UIKit


protocol memberDelegate : AnyObject {
    func addNewMember(_ mebmer : Member)
    func updateMemberInfo(index: Int, _ member: Member)
}


struct Member {
    
    lazy var memberImage : UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    static var memberNumber : Int = 0
    let memberId : Int
    var name : String?
    var age : Int?
    var phone : String?
    var address: String?
    
    
    init(name: String? = nil, age: Int? = nil, phone: String? = nil, address: String? = nil) {
        self.memberId = Member.memberNumber
        
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        Member.memberNumber += 1
    }
}
