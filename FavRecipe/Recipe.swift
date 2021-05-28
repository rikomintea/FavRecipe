//
//  Recipe.swiftR
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/25.
//

import Foundation
import RealmSwift


class Recipe: Object {
    @objc dynamic var recipeTitle: String = ""
    @objc dynamic var recipeImagePath: String = ""
    @objc dynamic var recipeURL: String = ""
//@objc dynamic var isGood: Boolean
    @objc dynamic var memo: String = ""
    
}
