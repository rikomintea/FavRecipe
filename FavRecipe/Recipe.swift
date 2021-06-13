//
//  Recipe.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/25.
//

import Foundation
import RealmSwift


class Recipe: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var recipeTitle: String = ""
    @objc dynamic var recipeURL: String = ""
    @objc dynamic var recipebook: String = ""
    @objc dynamic var recipepeople: String = ""

    @objc dynamic var memo: String = ""
    @objc dynamic var data: NSData!
    @objc dynamic var dataType: String = ""
    
    
//    //プライマリキーのプロパティ名を返却します。- Returns: プライマリキーのプロパティ名
//        
//    override static func primaryKey() -> String? {
//            return "id"
//        }
}
//@objc dynamic var data: NSData!



