//
//  RecipeEditViewController.swift
//  FavRecipe
//
//  Created by RIKO on 2021/05/30.
import UIKit

class RecipeEditViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var photoImageView: UIImageView!
    
    
    
    @IBAction func onTappedCameraButton(){
        presentPickerContoroller(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton(){
        print("osaretayonn")
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
    
    var recipeTitleLabel: UILabel!
    var recipeURLLabel: UILabel!
    var memoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}






//class RecipeEditViewController: UIViewController


