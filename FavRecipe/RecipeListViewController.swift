//  10366202
//  RecipeListViewController.swift
//  FavRecipe
//
//  Created by スマート・ナビ on 2021/05/23.
//


import UIKit
import RealmSwift

class RecipeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet var tableView: UITableView!
    //table view宣言
    
    let recipes = try!Realm().objects(Recipe.self)
    //オブジェクトの作成
    
    
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
    
    // tableViewのセルにアイテムを表示
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
    var bookTextField: UITextField!
    var peopleTextField: UITextField!
    
    
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
        
        //            indexNum = indexPath.row
        
        let recipe = recipes[indexPath.row]
        // 別の画面に遷移
        switch recipe.dataType {
        case "recipe":
            self.performSegue(withIdentifier: "AddRecipeViewController", sender: recipe)
        case "book":
            self.performSegue(withIdentifier: "AddbookRecipeViewController", sender: recipe)
        case "people":
            self.performSegue(withIdentifier: "AddpeopleRecipeViewController", sender: recipe)
            
        default:break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        switch segue.identifier {
        case "AddRecipeViewController":
            let nextVC = (segue.destination as? AddRecipeViewController)!
            nextVC.recipeData = sender as? Recipe
        case "AddbookRecipeViewController":
            let nextVC = (segue.destination as? AddbookRecipeViewController)!
        case "AddpeopleRecipeViewController":
            let nextVC = (segue.destination as? AddpeopleRecipeViewController)!
            
        
//        case "toRecipeInfoViewController":
//            let nextVC: RecipeInfoViewController = (segue.destination as? RecipeInfoViewController)!
//            nextVC.num = indexNum
//
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }//TableViewでRealmの値を編集可能にする
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(recipes[indexPath.row] as ObjectBase)
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func AddButton(_ sender: Any) {
        //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
        let alert: UIAlertController = UIAlertController(title:"", message: "参考にしたレシピのタイプを選んでください", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル")
        }
        let addAction: UIAlertAction = UIAlertAction(title: "Webサイト・アプリ", style: .default) { (UIAlertAction) in
            
            //            let AddRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
            //            self.present(AddRecipeViewController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "AddRecipeViewController", sender: nil)
            // 「削除」が押された時の処理
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {}
        }
        
        let addbookAction: UIAlertAction = UIAlertAction(title: "レシピ本", style: .destructive) { (UIAlertAction) in
            //             let AddbookRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddbookRecipeViewController") as! AddbookRecipeViewController
            //            self.present(AddbookRecipeViewController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "AddbookRecipeViewController", sender: nil)
            // 「削除」が押された時の処理
        }
        let addpeopleAction: UIAlertAction = UIAlertAction(title: "紹介者・マイアイデア", style: .destructive) { (UIAlertAction) in
            //            let AddpeopleRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddpeopleRecipeViewController") as! AddpeopleRecipeViewController
            //            self.present(AddpeopleRecipeViewController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "AddpeopleRecipeViewController", sender: nil)
            // 「削除」が押された時の処理
        }
        //アラートに設定を反映させる
        
        alert.addAction(addAction)
        alert.addAction(addbookAction)
        alert.addAction(addpeopleAction)
        alert.addAction(cancelAction)
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
        //アラートを表示する↑＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    }
    
    //struct ContentView: View {
    //    @State private var showingActionSheet = false // ①アクションシートの表示フラグ
    //        var body: some View {
    //         Button(Add) {
    //                self.showingActionSheet = true          // ②タップされたら表示フラグをtrueにする
    //            }
    //        .actionSheet(isPresented: $showingActionSheet) { // ③アクションシート表示条件設定
    //
    //                /// ④アクションシートの定義
    //        ActionSheet(title: Text("レシピのタイプ"), message: Text("参考にしたレシピのタイプを選んでください"), buttons:
    //                [
    //                    .default(Text("Webサイト・アプリ"), action: {
    //                        let AddRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
    //                        self.present(AddRecipeViewController, animated: true, completion: nil)
    //
    //                    }),
    //                    .default(Text("レシピ本"), action: {
    //                        let AddbookRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddbookRecipeViewController") as! AddbookRecipeViewController
    //                        self.present(AddbookRecipeViewController, animated: true, completion: nil)
    //
    //                    }),
    //                    .default(Text("紹介・マイアイデア"), action: {
    //                        let AddpeopleRecipeViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddpeopleRecipeViewController") as! AddpeopleRecipeViewController
    //                        self.present(AddpeopleRecipeViewController, animated: true, completion: nil)
    //
    //                    }),
    //                    cancel()
    //                                ]
    //                )
    //            }
    //        }
    //    }
    
    
    
    //動作
    
    //    @IBAction func onTappedUploadButton(){
    //        if photoImageView.image != nil{
    //           let activityVC = UIActivityViewController(activityItems:[photoImageView.image!,"#PhotoMaster"],
    //                                                  applicationActivities: nil)
    //           self.present(activityVC,animated: true,completion: nil)
    //        }else{
    //           print("画像がありません")
    //         }
    //
    //      }
    
    
    
    //    // 全件検索
    //   let realm: Realm
    //    do {
    //        realm = try Realm()
    //
    //        // 全件検索します。
    //        let results = realm.objects(PersonalInfo.self)
    //
    //        // 検索結果の件数を取得します。
    //        let count = results.count
    //        if (count == 0) {
    //            // 検索データ0件の場合
    //
    //        } else {
    //            // 検索データがある場合
    //
    //            // コレクションとしてアクセスする場合
    //            // resultは"PersonalInfo"クラスとしてアクセスできます。
    //            for result in results {
    //                print("\(result.name)")
    //            }
    //
    //            // インデックスを指定してアクセスする場合
    //            // results[i]は"PersonalInfo"クラスとしてアクセスできます。
    //            for i in 0 ..< count {
    //                print("\(results[i].age)")
    //            }
    //        }
    //    } catch {
    //        // 必要に応じて、エラー処理を行います。
    //    }
    
    
}



