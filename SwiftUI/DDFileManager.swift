//
//  DDFileManager.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/12.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit

class DDFileManager: NSObject {
    static let share: DDFileManager = DDFileManager()
    static func getShuMaBaoBeiData() -> ShuMaModel?{
        let bundle = Bundle.main.bundlePath + "/pokemon-25.json"
        guard let data = FileManager.default.contents(atPath:bundle) else {
            return nil
        }
        do {
            let shuMaModel = try  JSONDecoder().decode(ShuMaModel.self, from: data)
            return shuMaModel
        } catch   {
            return nil
        }
        
    }
}
struct ShuMaModel: Codable {
    var abilities: [Ability]
    
}

struct Ability: Codable {

    var ability:NameInfo
    var is_hidden: Bool
    var slot: Int
}
struct NameInfo:Codable {
    var name: String
    var url: String
}
