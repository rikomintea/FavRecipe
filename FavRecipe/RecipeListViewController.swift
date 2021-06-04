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
    //table view宣言
    
    
    
    
    let realm = Recipe()
    let recipes = try!Realm().objects(Recipe.self)
    //辞書型？に変換
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(recipes)
        
        return recipes.count
    }
    //セルの数はレシピの数の一致する
    
    

    var pictures: Results<PictureData>!
    //realm写真
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
            // Realmの初期化
            let realm = try! Realm()
        
            // Realmから保存されている写真のデータを取得
            pictures = realm.objects(PictureData.self)
            // tableViewを更新
            tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
        
        
    }
    
    
    
    
    
    
        
    // さっき作ったtableViewのセルにアイテムを表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Main.StoryboardのCellを探してくる
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListTableViewCell", for: indexPath) as! RecipeListTableViewCell
        // imageViewに写真を表示
        cell.recipeImage.image = UIImage(data: recipes[indexPath.row].data as Data)
        cell.recipeTitle.text = recipes[indexPath.row].recipeTitle
        // Cellに適用する
        return cell
    }
    
    var recipeTitleTextField: UITextField!
    var recipeURLTextField: UITextField!
    var memoTextField: UITextField!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //テーブルビューのデリゲートメソッド、データソースメソッドはViewControllerメソッドに書く
        tableView.delegate = self
        tableView.dataSource = self
        
        print (Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
  
    
    var indexNum = 0
    //セルの番号を記憶しておく変数
           

    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
            // セルの選択を解除
            tableView.deselectRow(at: indexPath, animated: true)
            
        
            indexNum = indexPath.row
            // 別の画面に遷移
            performSegue(withIdentifier: "toRecipeInfoViewController", sender: nil)
        }
    //cellがおされた時に呼ばれるメソッド
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toRecipeInfoViewController") {
            let nextVC: RecipeInfoViewController = (segue.destination as? RecipeInfoViewController)!
            nextVC.num = indexNum
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
      {
        return true
      }//編集可能

    
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//          try! realm.write {
//            realm.delete(recipes[indexPath.row] as ObjectBase)
//          }
//          tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
//        }
//    }
        //動作
        

    
    


   
    
}
