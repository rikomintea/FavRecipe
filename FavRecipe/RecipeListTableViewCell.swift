//
//  RecipeListTableViewCell.swift
//  FavRecipe
//
//  Created by RIKO on 2021/05/28.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeTitle: UILabel!
    
    override func setNeedsLayout() {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
