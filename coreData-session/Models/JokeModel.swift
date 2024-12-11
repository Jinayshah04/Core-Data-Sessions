//
//  JokeModel.swift
//  coreData-session
//
//  Created by mobile1 on 19/11/24.
//

import Foundation

struct JokeModel:Codable{
    let id:Int
    let type:String
    let setup:String
    let punchline:String
}
