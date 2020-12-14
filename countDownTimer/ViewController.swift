//
//  ViewController.swift
//  countDownTimer
//
//  Created by 谷口祐人 on 2020/10/26.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate  {
    
    
    //ピッカーに使用するグローバル宣言
//    　ピッカーにカウントする数字１
        var firstCount = [Int]()

    
//        ピッカーに値を返した時の数字
        var firstLabel = UILabel()
//        ピッカーに値を返した時の数字
        var secondLabel = UILabel()
    
//        ピッカーが算出した値を代入するための変数
        var nowAge = 0
        var futureAge = 0
        var resultYear = 0
        var resultSecond = 0
        var totalSec = 0 //渡す値
        // ピッカーに表示させる配列
        var AgeArray = [String]()
        
        var pkView = UIImageView()
        var selectLabel = 0
    
        var age = 0
        
       

    
//ピッカービューの中身を設定する
//ピッカービューの作成関数
func makePicker() {
    for i in 0...120 {//テキスト配列の作成
            AgeArray.append(String(i))
           
        }
        let origin = CGPoint(x: 0, y: 20)//ピッカービューの左上の座標
        let size = CGSize(width: 200, height: 150)//ピッカービューのサイズ
        let rect = CGRect(origin: origin, size: size)//ピッカービューの枠
        let picker = UIPickerView(frame: rect)
        picker.delegate = self//ピッカービューのデリゲート
        picker.dataSource = self//ピッカービューのデーターソース
        picker.selectRow(0, inComponent: 0, animated: true)//１列目(inComponent = 0)に配列の要素0("1")を指定(初期値)
        picker.backgroundColor = UIColor.white
        picker.tag = tagNo["picker"]!//ピッカービューのタグを設定
        picker.center.x = pkView.center.x
        pkView.addSubview(picker)//ピカービューを表示
        pkView.isHidden = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //初期設定①のピッカービューの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //初期設定②各列の表示数を指定(componentはシステムで予約されていて自動的に割り振られます)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var counts = 0
        if component == 0{
            counts = AgeArray.count
            
        }
        return counts
    }
    //初期設定③表示内容を指定(rowはシステムで予約されていて自動的に割り振られます)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        var counts = ""
        if component == 0{
            counts = AgeArray[row]
            //rowはシステム定数なので暗記
        }
        return counts
    
    }
    //初期設定④//ピッカーの値が変化した時の処理(rowはシステムで予約されていて自動的に割り振られます)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ピッカーによって算出された数字
        //値→文字⇨値にしてあげなきゃ
        
        if component == 0{
            switch selectLabel {
            case tagNo["nowAgeLabel"]!:
                let counts = AgeArray[row]
                nowAge = Int(counts)!
                age = nowAge
            case tagNo["futureAgeLabel"]!:
                let counts = AgeArray[row]
                futureAge = Int(counts)!
                age = futureAge
            default:
                break
            }
            
           
           
        }
    }

           

    
    
    
    
    
    
    var maxWidth = 0
    var maxHeight = 0
    
    var tagNo = [String:Int]()
    var tagCount = ["header","mainTitle","main","footer","nowAge","calc","countDown","toSecond","okBtnTag","picker","nowAgeLabel","futureAgeLabel", "selectLabel"]
   
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        
        for i in 0..<tagCount.count{
                  tagNo[tagCount[i]] = i + 1
                  }
      
        //ヘッダー呼び出し
        dwHeader()
        //タイトル呼び出し
        dwTitle()
        //トップ画ー呼び出し
        dwMain()
        //フッター呼び出し
        dwFooter()
        //今何歳？
        bthday()
        //年齢を入れるテキストフィールド
        DrawLabel()
        
        //検索ボタン
        dwButton()
       
        //ピッカービュー用UIimageView
        pickerView()
        //ピッカービュー本体
        makePicker()
       
       print(tagNo)
    }
    func pickerView(){
        var rect = CGRect(x: 0, y: self.view.frame.height * 2 / 3, width: self.view.frame.width, height: self.view.frame.height / 3)
        
            pkView.frame = rect
            pkView.backgroundColor = UIColor.lightGray
            pkView.isUserInteractionEnabled = true
            self.view.addSubview(pkView)
        
            rect.origin.x = self.view.frame.maxX * 5 / 6
            rect.origin.y = 10
        let okBtn = makeButton(rect: rect, color: UIColor.blue, text: "完了", corner: 0)
            okBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            okBtn.sizeToFit()
            okBtn.tag = tagNo["okBtnTag"]!
            
            pkView.addSubview(okBtn)
    }
    


    
    //ヘッダー貼り付け
    func dwHeader(){
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 5)
        let rect = CGRect(origin: origin, size: size)
        let drawHeader = makeView(rect: rect, color: UIColor.black)
            drawHeader.tag = tagNo["header"]!
            self.view.addSubview(drawHeader)
    }
    //タイトル名貼り付け
    func dwTitle(){
        let header = self.view.viewWithTag(tagNo["header"]!) as! UIImageView
        let origin = CGPoint(x: 0, y: header.frame.midY)
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 10)
        let rect = CGRect(origin: origin, size: size)
        let drawTitle = makeLabel(rect: rect, color: UIColor.red, text: "死へのカウントダウン")
            drawTitle.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 10)
            drawTitle.sizeToFit()
            drawTitle.center.x = self.view.center.x
            header.addSubview(drawTitle)
            
    }
    //メイン画像貼り付け
    func dwMain(){
        let header = self.view.viewWithTag(tagNo["header"]!) as! UIImageView
        let origin = CGPoint(x: 0, y: header.frame.maxY)
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 3)
        let rect = CGRect(origin: origin, size: size)
        let drawMainView = makeImageView(rect:rect,image:UIImage(named: "horror.jpg")!)
            drawMainView.tag = tagNo["main"]!
            self.view.addSubview(drawMainView)
    }
    //フッタービュー貼り付け
    func dwFooter(){
        let main = self.view.viewWithTag(tagNo["main"]!) as! UIImageView
        let origin = CGPoint(x: 0, y: main.frame.maxY)
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 2)
        let rect = CGRect(origin: origin, size: size)
        let drawFooter = makeView(rect: rect, color: UIColor.black)
            drawFooter.isUserInteractionEnabled = true
            drawFooter.tag = tagNo["footer"]!
            self.view.addSubview(drawFooter)
    }
    //今の年齢貼り付け
    func bthday(){
        let footer = self.view.viewWithTag(tagNo["footer"]!) as! UIImageView
        let origin = CGPoint(x: self.view.frame.maxX / 10, y: 0)
        //なぜ？
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 12)
        let rect = CGRect(origin: origin, size: size)
        let drawBirthDay = makeLabel(rect:rect,color:UIColor.white,text:"年齢を入力してください。")
            drawBirthDay.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 14)
            drawBirthDay.tag = tagNo["nowAge"]!
            footer.addSubview(drawBirthDay)
         
        
    }
    //textFieldで現在の年齢を入力させる
    func DrawLabel(){
        let nowAge = self.view.viewWithTag(tagNo["nowAge"]!) as! UILabel
        let footer = self.view.viewWithTag(tagNo["footer"]!) as! UIImageView
        var origin = CGPoint(x: nowAge.frame.minX, y: nowAge.frame.maxY)
        var size = CGSize(width: self.view.frame.width / 1.5, height: self.view.frame.height / 20)
        var rect = CGRect(origin: origin, size: size)
        let DrawNowAgeLabel = makeLabel(rect: rect, color: UIColor.black, text: "現在の年齢")
            DrawNowAgeLabel.center.x = self.view.center.x
            DrawNowAgeLabel.backgroundColor = UIColor.white
            DrawNowAgeLabel.isUserInteractionEnabled = true
            DrawNowAgeLabel.textAlignment = .center
            DrawNowAgeLabel.tag = tagNo["nowAgeLabel"]!
            // プレースホルダを設定
        
            footer.addSubview(DrawNowAgeLabel)
            
            
            origin = CGPoint(x: DrawNowAgeLabel.frame.minX, y: DrawNowAgeLabel.frame.maxY + self.view.frame.height / 20)
            size = CGSize(width: self.view.frame.width / 1.5, height: self.view.frame.height / 20)
            rect = CGRect(origin: origin, size: size)
        let DrawFutureAgeLabel = makeLabel(rect: rect, color: UIColor.black, text: "あなたの寿命")
            DrawFutureAgeLabel.isUserInteractionEnabled = true
            DrawFutureAgeLabel.backgroundColor = UIColor.white
            DrawFutureAgeLabel.textAlignment = .center
            DrawFutureAgeLabel.tag = tagNo["futureAgeLabel"]!
            footer.addSubview(DrawFutureAgeLabel)
            
    }
    //ここから
    //さらに何歳まで生きるか計算する(実際は残秒数を渡すだけ)
        func dwButton (){

                let origin = CGPoint(x: 0, y: self.view.frame.maxY / 1.2)
                let size = CGSize(width: self.view.frame.width / 1.2, height: self.view.frame.height / 15)
                let rect = CGRect(origin: origin, size: size)
            let drawBtn =  makeButton(rect:rect,color:UIColor.red,text:"計算する。",corner:20)
                drawBtn.tag = tagNo["calc"]!
                drawBtn.center.x = self.view.center.x
                self.view.addSubview(drawBtn)
        
    }
    //ボタンで遷移させる
    
    
    
    
    
    
    //ビュー作成の汎用関数
    func makeView(rect:CGRect,color:UIColor)->UIImageView{
        let mkView = UIImageView()
            mkView.frame = rect
            mkView.backgroundColor = color
            return mkView
        }
    //ビュー作成の汎用関数
    func makeImageView(rect:CGRect,image:UIImage)->UIImageView{
        let mkView = UIImageView()
            mkView.frame = rect
            mkView.image = image
            return mkView
    }

    //ラベル貼り付けの汎用関数
    func makeLabel(rect:CGRect,color:UIColor,text:String)->UILabel{
        let mkLabel = UILabel()
            mkLabel.frame = rect
            mkLabel.textColor = color
            mkLabel.text = text
            return mkLabel
    }
    //TextField作成の汎用関数
    func makeTextField(rect:CGRect,color:UIColor)->UITextField{
        let mkTextField = UITextField()
            mkTextField.frame = rect
            mkTextField.backgroundColor = color
            return mkTextField
    }
    //ボタンがタップされたら
    @objc func pushBtn(btn: UIButton) {
        let tag = btn.tag//タップされたボタンのタグを取得
            switch tag {
                case tagNo["calc"]!:
                    //年齢計算
                    calAge()
                    moveView("secondView", totalSec: totalSec)
                case tagNo["okBtnTag"]!:
                pkView.isHidden = true
                    let label = self.view.viewWithTag(selectLabel) as! UILabel
                    label.text  = String(age)
                default:
                    break
            }
    }
    
     
    //ボタン作成の汎用関数
    func makeButton(rect:CGRect,color:UIColor,text:String,corner:CGFloat)->UIButton{
        let mkButton = UIButton()
            mkButton.frame = rect
            mkButton.backgroundColor = color
            mkButton.layer.cornerRadius = corner
            mkButton.setTitle(text, for: UIControl.State.normal)
            mkButton.addTarget(self, action: #selector(pushBtn), for: .touchUpInside)
            return mkButton
    }

  
    //タイマー関係
   
    //計算式
    func calAge(){
            resultYear = futureAge - nowAge
            totalSec = resultYear * 365 * 24 * 60 * 60

    }

    //値を渡してsecondViewに遷移
    func moveView(_ viewName: String, totalSec: Int){
        let storyboard: UIStoryboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: viewName) as! secondViewController
       

        next.totalSec = totalSec //渡す値//totalSecを遷移先で作る
        
        next.modalPresentationStyle = .fullScreen
        self.present(next, animated: true, completion: nil)
    }
//  タッチイベントが発生したら
    override func touchesBegan(_ touches: Set<UITouch>,  with event: UIEvent?) {
        let touche = touches.first!//イベントを取得
        let tag = touche.view!.tag//タッチされたviewのtagを取得
        switch tag {
        case tagNo["nowAgeLabel"]!:
            pkView.isHidden = false
            selectLabel = tagNo["nowAgeLabel"]!
        case tagNo["futureAgeLabel"]!  :
            pkView.isHidden = false
            selectLabel = tagNo["futureAgeLabel"]!
        default:
            break
        }
    }
    
}



