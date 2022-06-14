//
//  ViewController.swift
//  202116054_test
//
//  Created by 203a10 on 2022/06/10.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var isHat = false
    var isGlasses = false
    var isGameover = false
    var howEat = 0
    var howTouch = 0
    var catLuv = 0
    var coin = 0
    
    var imgCat: UIImage?
    var imgCatHat: UIImage?
    var imgCatGlasses: UIImage?
    var imgCatHG: UIImage?
    
    @IBOutlet var lblCoin: UILabel!
    @IBOutlet var lblCatLuv: UILabel!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnCatMotion: UIButton!
    @IBOutlet var btnCatEat: UIButton!
    @IBOutlet var btnWork: UIButton!
    @IBOutlet var btnGames: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgCat = UIImage(named: "cat.jpeg")
        imgCatHat = UIImage(named: "cat_hat.jpeg")
        imgCatGlasses = UIImage(named: "cat_glass.jpeg")
        imgCatHG = UIImage(named: "cat_hat_glass.jpeg")
        
        imgView.image = imgCat
        lblCatLuv.text = "호감도: " + String(catLuv)
        lblCoin.text = "코인: " + String(coin)
        
        if (catLuv < 0) {
            lblText.text = "게임오버"
            isGameover = true
        }
    }
    
    @IBAction func btnCatMotionM(_ sender: UIButton) {
        if (howTouch == 30) {
            lblText.text = "고양이가 거부합니다."
        } else if (howTouch < 30 && isGameover == false){
        lblText.text = "고양이의 호감도가 +1 상승하였습니다."
        catLuv += 1
        howTouch += 1
        lblCatLuv.text = "호감도: " + String(catLuv)
        } else if (isGameover == true) {
            GameOver()
        }
    }
    @IBAction func btnCatEatM(_ sender: UIButton) {
        if (howEat < 5 && coin > 49 && isGameover == false) {
            let Qfood = UIAlertController(title: "무엇을 줄까요?", message: "선택하세요", preferredStyle: UIAlertController.Style.alert)
            let catEat1 = UIAlertAction(title: "소시지 (50코인)", style: UIAlertAction.Style.default, handler: {
                ACTION in self.lblText.text = "호감도가 +50 상승하였습니다."
                self.catLuv += 50
                self.howEat += 1
                self.coin -= 50
                self.lblCatLuv.text = "호감도: " + String(self.catLuv)
                self.lblCoin.text = "코인: " + String(self.coin)
                })
            let catEat2 = UIAlertAction(title: "참치 (50코인)", style: UIAlertAction.Style.default, handler: {
                ACTION in self.lblText.text = "호감도가 +50 상승하였습니다."
                self.catLuv += 50
                self.howEat += 1
                self.coin -= 50
                self.lblCatLuv.text = "호감도: " + String(self.catLuv)
                self.lblCoin.text = "코인: " + String(self.coin)
            })
            let catRandom = UIAlertAction(title: "무작위 (50코인)", style: UIAlertAction.Style.default, handler: {
                ACTION in self.FRandom()
                self.howEat += 1
                self.coin -= 50
                self.lblCatLuv.text = "호감도: " + String(self.catLuv)
                self.lblCoin.text = "코인: " + String(self.coin)
            })
            
            Qfood.addAction(catEat1)
            Qfood.addAction(catEat2)
            Qfood.addAction(catRandom)
            
            present(Qfood, animated: true, completion: nil)
            
        } else if (howEat > 5 && isGameover == false) {
            lblText.text = "더이상 먹이를 줄 수 없습니다."
        } else if (coin < 50 && isGameover == false) {
            lblText.text = "코인이 부족합니다."
        } else if (isGameover == true) {
            GameOver()
        }
    }
    
    @IBAction func switchHat(_ sender: UISwitch) {
        if sender.isOn {
            if (catLuv < 200) {
                lblText.text = "호감도 200이상만 이용가능합니다."
            } else {
                isHat = true
                if (isGlasses == true) {
                    imgView.image = imgCatHG
                } else {
                    imgView.image = imgCatHat
                }
            }
        } else {
            isHat = false
            if (isGlasses == true) {
                imgView.image = imgCatGlasses
            } else {
                imgView.image = imgCat
            }
        }
    }
    
    @IBAction func switchGlasses(_ sender: UISwitch) {
        if sender.isOn {
            if (catLuv < 400) {
                lblText.text = "호감도 400이상만 이용가능합니다."
            } else {
                isGlasses = true
                if (isHat == true) {
                    imgView.image = imgCatHG
                } else {
                    imgView.image = imgCatGlasses
                }
            }
        } else {
            isGlasses = false
            if (isHat == true) {
                imgView.image = imgCatHat
            } else {
                imgView.image = imgCat
            }
        }
    }
    
    @IBAction func btnWorkMotion(_ sender: UIButton) {
        if (isGameover == false) {
            lblText.text = "1코인을 벌었습니다."
            coin += 1
            lblCoin.text = "코인: " + String(coin)
        } else {
            GameOver()
        }
    }
    
    @IBAction func btnGame(_ sender: UIButton) {
        if (coin > 4 && isGameover == false) {
            let gameChoice = UIAlertController(title: "선택하세요", message: "5코인 필요", preferredStyle: UIAlertController.Style.alert)
            let gamex2 = UIAlertAction(title: "코인 +-2배(50%확률)", style: UIAlertAction.Style.default, handler: {
                ACTION in self.coin -= 5
                self.F2Random()
            })
            let gamex5 = UIAlertAction(title: "코인 +-5배(10%확률)", style: UIAlertAction.Style.default, handler: {
                ACTION in self.coin -= 5
                self.F5Random()
            })
        
            gameChoice.addAction(gamex2)
            gameChoice.addAction(gamex5)
        
            present(gameChoice, animated: true, completion: nil)
        
        } else if (coin < 6 && isGameover == false) {
            lblText.text = "코인이 부족합니다."
        } else if (isGameover == true) {
            GameOver()
        }
        
    }
    
    func FRandom() {
        var foodRandom = Int.random(in: 1...5)
        if (foodRandom == 1) { //
            lblText.text = "'생선가시', 고양이의 호감도가 -50 줄었습니다."
            catLuv -= 50
            lblCatLuv.text = "호감도: " + String(catLuv)
        } else if (foodRandom == 2) {
            lblText.text = "'일반사료', 고양이의 호감도가 +5 상승하였습니다."
            catLuv += 5
            lblCatLuv.text = "호감도: " + String(catLuv)
        } else if (foodRandom == 3) {
            lblText.text = "'물', 고양이의 호감도가 +0 상승하였습니다."
            catLuv += 0
            lblCatLuv.text = "호감도: " + String(catLuv)
        } else if (foodRandom == 4) {
            lblText.text = "'츄르', 고양이의 호감도가 +200 상승하였습니다."
            catLuv += 200
            lblCatLuv.text = "호감도: " + String(catLuv)
        } else {
            lblText.text = "'채소', 고양이의 호감도가 -20 줄었습니다."
            catLuv -= 20
            lblCatLuv.text = "호감도: " + String(catLuv)
        }
    }
    
    func F2Random() {
        var coinRandom2 = Int.random(in: 1...2)
        if (coinRandom2 == 1) {
            lblText.text = "성공 !"
            coin = coin * 2
            lblCoin.text = "코인: " + String(coin)
        } else if (coinRandom2 == 2) {
            lblText.text = "실패 !"
            coin = coin / 2
            lblCoin.text = "코인: " + String(coin)
        }
    }
    
    func F5Random() {
        var coinRandom5 = Int.random(in: 1...10)
        if (coinRandom5 <= 9) {
            lblText.text = "실패 !"
            coin = coin / 5
            lblCoin.text = "코인: " + String(coin)
        } else {
            lblText.text = "성공 !"
            coin = coin * 5
            lblCoin.text = "코인: " + String(coin)
        }
    }
    
    func GameOver() {
        lblText.text = "게임을 재시작하세요"
    }
}
