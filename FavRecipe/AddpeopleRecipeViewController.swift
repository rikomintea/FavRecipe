//
//  AddpeopleRecipeViewController.swift
//  FavRecipe
//
//  Created by RIKO on 2021/06/11.
//

import UIKit
import RealmSwift

class AddpeopleRecipeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate, UITextViewDelegate{
    
    
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var albumButton: UIButton!
    var saveButton: UIBarButtonItem!
    
    @IBOutlet var photoImageView: UIImageView!
    
    
    var recipeData: Recipe!
    
    
    
    
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
    @IBOutlet var recipepeopleTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.recipeTitleTextField.delegate = self
        self.recipepeopleTextField.delegate = self
        self.memoTextView.delegate = self
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 12
        
        if recipeData != nil {
            photoImageView.image  = UIImage(data: recipeData.data as Data)
            recipeTitleTextField.text = recipeData.recipeTitle
            recipepeopleTextField.text = recipeData.recipeURL
            memoTextView.text = recipeData.memo
            recipeTitleTextField.isEnabled = false
            recipepeopleTextField.isEnabled = false
            memoTextView.isEditable = false
            memoTextView.isSelectable = false
            albumButton.isHidden = true
            cameraButton.isHidden = true
            saveButton = UIBarButtonItem(title: "編集" , style: .plain, target: self, action: #selector(didTapEdit))
            navigationItem.setRightBarButton(saveButton, animated: false)
        } else {
            saveButton = UIBarButtonItem(title: "保存" , style: .plain, target: self, action: #selector(addRecipe(_:)))
            navigationItem.setRightBarButton(saveButton, animated: false)
        }
    }
    
    @IBAction func didTapEdit(){
        recipeTitleTextField.isEnabled = true
        recipepeopleTextField.isEnabled = true
        memoTextView.isEditable = true
        memoTextView.isSelectable = true
        albumButton.isHidden = false
        cameraButton.isHidden = false
        saveButton = UIBarButtonItem(title: "保存" , style: .plain, target: self, action: #selector(addRecipe(_:)))
        navigationItem.setRightBarButton(saveButton, animated: false)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recipeTitleTextField.resignFirstResponder()
        recipepeopleTextField.resignFirstResponder()
        memoTextView.resignFirstResponder()
        return true
    }
    //keyboardが消える
    
    
    @IBAction func addRecipe(_ sender: Any) {
        //nilじゃなかったら新しいのを更新
        if recipeData != nil {
            //            let currentRecipe = realm.objects(Recipe.self).filter("id == \(recipeData.id)")
            try! realm.write {
                recipeData.recipeTitle = recipeTitleTextField.text!
                recipeData.recipepeople = recipepeopleTextField.text!
                recipeData.memo = memoTextView.text!
            }
        } else {
        //nilだったら新しいのを作る
            let newRecipe = Recipe()
            newRecipe.recipeTitle = recipeTitleTextField.text!
            newRecipe.recipepeople = recipepeopleTextField.text!
            newRecipe.memo = memoTextView.text!
            newRecipe.dataType = "recipe"
            //newRecipe.recipeImagePath =
            // 写真を変換
            let data = NSData(data: photoImageView.image!.jpegData(compressionQuality: 0.9)!)
            
            newRecipe.data = data
            
            
            try! realm.write {
                realm.add(newRecipe)
                
            }
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
