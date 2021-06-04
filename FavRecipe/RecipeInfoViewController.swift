//
//  RecipeInfoViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//

import UIKit
import RealmSwift
class RecipeInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate{
    
    
    var num = Int()
    
    var recipe = try!Realm().objects(Recipe.self)
    var recipeImage:PictureData!
    
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var recipeTitleTextField: UITextField!
    @IBOutlet var recipeURLTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()//意外と大切な子
        photoImageView.image  = UIImage(data: recipe[num].data as Data)
        recipeTitleTextField.text = recipe[num].recipeTitle
        recipeURLTextField.text = recipe[num].recipeURL
        memoTextField.text = recipe[num].memo
    }
    
    
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recipeTitleTextField.resignFirstResponder()
        recipeURLTextField.resignFirstResponder()
        memoTextField.resignFirstResponder()
        return true
    }
//keyboardが消える
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func addRecipe(_ sender: Any) {
        
        let newRecipe = Recipe()
        newRecipe.recipeTitle = recipeTitleTextField.text!
        newRecipe.recipeURL = recipeURLTextField.text!
        newRecipe.memo = memoTextField.text!
        
       
        dismiss(animated: true, completion: nil)
        
        
        let alert = UIAlertController(
            title: "保存完了",
            message: "レシピの登録が完了しました",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler:nil
            
        ))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancel() {
        self.navigationController?.popViewController(animated: true)
        
//        dismiss(animated: true, completion: nil)
    }
}


