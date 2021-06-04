//
//  AddRecipeViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//

import UIKit
import RealmSwift

class AddRecipeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate{



    @IBOutlet var photoImageView: UIImageView!
    
    
    @IBAction func onTappedCameraButton(){
        presentPickerContoroller(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton(){
        presentPickerContoroller(sourceType: .photoLibrary)
    }
    
    
    func presentPickerContoroller(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
        }
    }
    
    
    
    
    
    func imagePickerController(_ picker:UIImagePickerController,
                               didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        
            // 撮影した写真の取得
        photoImageView.image = info[.originalImage] as? UIImage
            
        
        self.dismiss(animated: true,completion: nil)
        
        
    }
    
    
    
    
    
    
    @IBOutlet var recipeTitleTextField: UITextField!
    @IBOutlet var recipeURLTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    let realm = try! Realm()
 
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.recipeTitleTextField.delegate = self
        self.recipeURLTextField.delegate = self
        self.memoTextField.delegate = self
        
        
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
        //newRecipe.recipeImagePath =
        // 写真を変換
        let data = NSData(data: photoImageView.image!.jpegData(compressionQuality: 0.9)!)
        
        newRecipe.data = data
        
        
        
        
        try! realm.write {
            print("ちゃんと保存されました")
            realm.add(newRecipe)
        }
        
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
