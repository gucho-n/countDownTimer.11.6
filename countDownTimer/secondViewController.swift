//
//  secondViewController.swift
//  countDownTimer
//
//  Created by 谷口祐人 on 2020/10/30.
//

import UIKit

class secondViewController: UIViewController {
    
    var tagNo = [String:Int]()
    var tagCount = ["header","mainTitle","main","footer","nowAge","countDownSec","countDownMin","countDownHour","toFirst"]
    var resultSecond:Int = 0
    var resultMonth = 0
    var resultHour = 0
    var resultMin = 0
    var totalSec = 0
    var resultZeroHour:Bool!
    var resultZeroMin:Bool!
    
   
    
    
    
    //タイマー作成
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for i in 0..<tagCount.count{
                  tagNo[tagCount[i]] = i + 1
                  }

        
        dwHeader()
        dwTitle()
        dwMain()
        dwFooter()
        
        //タイマーセット

//        timeSetHour()
//        timeSetMin()
        timeSetSec ()
        // Do any additional setup after loading the view.
       
    }



    //0にしたら引き渡された値も0にならないのかな？
     
    //画面描画
    
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
        let drawTitle = makeLabel(rect: rect, color: UIColor.red, text: "あなたの残り時間は,,,")
            drawTitle.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 12)
            drawTitle.center.x = self.view.center.x
            header.addSubview(drawTitle)
            
    }
    //メイン貼り付け
    func dwMain(){
        let header = self.view.viewWithTag(tagNo["header"]!) as! UIImageView
        var origin = CGPoint(x: 0, y: header.frame.maxY)
        var size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 3)
        var rect = CGRect(origin: origin, size: size)
        let drawMain = makeView(rect: rect, color: UIColor.black)
            drawMain.tag = tagNo["main"]!
            drawMain.backgroundColor = UIColor.black
            header.addSubview(drawMain)

            //時間
            origin = CGPoint(x: 0, y: drawMain.bounds.minY)
            size = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height / 10)
            rect = CGRect(origin: origin, size: size)
        let drawHour = makeLabel(rect: rect, color: UIColor.red, text: "残り")
            drawHour.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 10)
            
            drawHour.center.x = self.view.center.x
        
            drawMain.addSubview(drawHour)
            //時間計算 考え直し
//        origin = CGPoint(x: self.view.frame.maxX / 2, y: drawMain.bounds.minY)
//            size = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height / 10)
//            rect = CGRect(origin: origin, size: size)
//        let calHour = makeLabel(rect: rect, color: UIColor.red, text: "\(resultHour)")
//            calHour.backgroundColor = UIColor.blue
//            calHour.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 10)
//            calHour.sizeToFit()
//            calHour.tag = tagNo["countDownHour"]!
//            drawMain.addSubview(calHour)
//
//
//
//            //分
//                origin = CGPoint(x: 0, y: drawHour.bounds.maxY + drawMain.frame.height / 3)
//                size = CGSize(width: self.view.frame.width / 2, height: self.view.frame.height / 10)
//                rect = CGRect(origin: origin, size: size)
//            var drawMin = makeLabel(rect: rect, color: UIColor.red, text: "分")
//                drawMin.font = UIFont.systemFont(ofSize: self.view.frame.maxX / 10)
//                drawMin.sizeToFit()
//                drawMin.backgroundColor = UIColor.blue
//
//                drawMain.addSubview(drawMin)
//
//                origin = CGPoint(x: self.view.frame.maxX / 2, y: drawHour.bounds.maxY + drawMain.frame.height / 3)
//                size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 10)
//                rect = CGRect(origin: origin, size: size)
//            var calMin = makeLabel(rect: rect, color: UIColor.red, text: "\(resultMin)")
//                calMin.font = UIFont.systemFont(ofSize: 20)
//                calMin.sizeToFit()
//                calMin.backgroundColor = UIColor.blue
//                calMin.tag = tagNo["countDownMin"]!
//                drawMain.addSubview(calMin)
//
            //秒
        origin = CGPoint(x: 0, y: self.view.frame.maxX * 1 / 3)
                size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 10)
                rect = CGRect(origin: origin, size: size)
            var calSec = makeLabel(rect: rect, color: UIColor.red, text: "\(totalSec)")
                calSec.font = UIFont.systemFont(ofSize: 40)
                calSec.textAlignment = NSTextAlignment.right
                
                calSec.tag = tagNo["countDownSec"]!
                drawMain.addSubview(calSec)


        }
//    フッタービュー貼り付け
    func dwFooter(){
        let main = self.view.viewWithTag(tagNo["main"]!) as! UIImageView
        var origin = CGPoint(x: 0, y: main.frame.maxY)
        var size = CGSize(width: self.view.frame.width, height: self.view.frame.height / 2)
        var rect = CGRect(origin: origin, size: size)
        let drawHeader = makeView(rect: rect, color: UIColor.black)
            drawHeader.tag = tagNo["footer"]!
            self.view.addSubview(drawHeader)
    

        origin = CGPoint(x: 0, y: self.view.frame.height * 5 / 7)
            size = CGSize(width: self.view.frame.width / 1.2, height: self.view.frame.height / 15)
            rect = CGRect(origin: origin, size: size)
        let drawBtn =  makeButton(rect:rect,color:UIColor.red,text:"もどる。",corner:20)
                drawBtn.tag = tagNo["toFirst"]!
                drawBtn.center.x = self.view.center.x
                self.view.addSubview(drawBtn)
        
    
        
        
    }
    
    
    
    
    
    //値を渡さず画面遷移
    func moveView(_ viewName: String) {
        let storyboard: UIStoryboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: "firstView")
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
    }
    //ボタンがタップされたら
    @objc func pushBtn(btn: UIButton) {
        let tag = btn.tag//タップされたボタンのタグを取得
        switch tag {
        case tagNo["toFirst"]!:
            moveView("firstView")
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

    
  //イメージビュー作成の汎用関数
    func makeView(rect:CGRect,color:UIColor)->UIImageView{
        let mkView = UIImageView()
            mkView.frame = rect
            mkView.backgroundColor = color
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
    //ビュー作成の汎用関数
    func makeImageView(rect:CGRect,image:UIImage)->UIImageView{
        let mkView = UIImageView()
            mkView.frame = rect
            mkView.image = image
            return mkView
    }
    //タイナーの変化
    
    //時間
    @objc func timeDrawHour (_ timer:Timer){
        
            let label = self.view.viewWithTag(tagNo["countDownHour"]!) as! UILabel
                resultHour -= 1
            if  resultHour <= 0{
                resultHour = 0
        }
        
                label.text = "\(resultHour)"
           
    }
    
    //分
    
//
//    @objc func timeDrawMin (_ timer:Timer){
//
//            let label = self.view.viewWithTag(tagNo["countDownMin"]!) as! UILabel
//                resultMin -= 1
//            if resultHour == 0 {
//                return
//            }
//            if  resultMin <= 0  {
//                resultMin = 59
//        }
//
//
//        label.text = "\(resultMin)"
//    }
        
    
    //秒
    @objc func timeDrawSec (_ timer:Timer){
        
            let label = self.view.viewWithTag(tagNo["countDownSec"]!) as! UILabel
                totalSec -= 1
            
            if  totalSec <= 0{
                totalSec = 59
        }
        label.text = "\(totalSec)"
        
           
    

    }
    //タイマー初期設定
    //時間
//    func timeSetHour (){
//            timer = Timer.scheduledTimer(
//            timeInterval: 3600.0,
//            target: self,
//            selector: #selector(secondViewController.timeDrawHour(_:)),
//            userInfo: nil,
//            repeats: true
//        )
//    }
//    //分
//    func timeSetMin (){
//            timer = Timer.scheduledTimer(
//            timeInterval: 60.0,
//            target: self,
//            selector: #selector(secondViewController.timeDrawMin(_:)),
//            userInfo: nil,
//            repeats: true
//        )
//    }
    //秒
    func timeSetSec (){
            timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(secondViewController.timeDrawSec(_:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    

}
