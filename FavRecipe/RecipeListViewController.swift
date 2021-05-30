//  10366202
//  RecipeListViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//


import UIKit
import RealmSwift


class RecipeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try!Realm()
    
    let recipes = try!Realm().objects(Recipe.self)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return recipes.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListTableViewCell", for: indexPath as IndexPath)as!RecipeListTableViewCell
        cell.recipeTitle.text = recipes[indexPath.row].recipeTitle
        cell.recipeImage.image = UIImage(contentsOfFile:recipes[indexPath.row].recipeImagePath)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print (Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
           

    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
            // セルの選択を解除
            tableView.deselectRow(at: indexPath, animated: true)
    
            // 別の画面に遷移
            performSegue(withIdentifier: "toRecipeVIewController", sender: nil)
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
