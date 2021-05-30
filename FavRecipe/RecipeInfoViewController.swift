//
//  RecipeInfoViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//

import UIKit

class RecipeInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate{
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var recipeTitleTextField: UITextField!
    @IBOutlet var recipeURLTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        
        
        
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


