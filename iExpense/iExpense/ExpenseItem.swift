//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Shishira on 10/11/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import Foundation

struct ExpenseItem : Identifiable, Codable{
    let id = UUID()
    let name : String
    let type : String
    let amount : Int
}
