//
//  AddRecipeViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//

import UIKit
import RealmSwift

class AddRecipeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
   
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
   
   self.dismiss(animated: true,completion: nil)
       
   photoImageView.image = info[.originalImage]as?UIImage
   }
    
   
   @IBAction func onTappedUploadButton(){
       if photoImageView.image != nil{
           let activityVC = UIActivityViewController(activityItems:[photoImageView.image!,"#PhotoMaster"],
                                                     applicationActivities: nil)
           self.present(activityVC,animated: true,completion: nil)
       }else{
           print("画像がありません")
       }
   
   }


    
   
    @IBOutlet var recipeTitleTextField: UITextField!
    @IBOutlet var recipeURLTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    @IBAction func addRecipe(_ sender: Any) {
        let newRecipe = Recipe()
        newRecipe.recipeTitle = recipeTitleTextField.text!
        newRecipe.recipeURL = recipeURLTextField.text!
        newRecipe.memo = memoTextField.text!
        
        try! realm.write {
            realm.add(newRecipe)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     
     
     var recipeTitleLabel
     var URLLabel
     var memoLabel
     
     @IBOutlet var recipeTitleLabel: UILabel!
     var URLLabel: UILabel!
     var memoLabel: UILabel!
    }
    */

}

