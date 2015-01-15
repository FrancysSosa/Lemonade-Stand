//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Vacano on 1/8/15.
//  Copyright (c) 2015 Vacano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //program works fine, but i did not create a supplies struct or price struct there for struggled getting and setting values to the labels.
    
    @IBOutlet weak var moneyAmountIHave: UILabel!
    @IBOutlet weak var lemonAmountIHave: UILabel!
    @IBOutlet weak var iceCubeAmountIHave: UILabel!
    @IBOutlet weak var buyReturnLemonsLabel: UILabel!
    @IBOutlet weak var buyReturnIceCubesLabel: UILabel!
    @IBOutlet weak var addSubtractLemonsToMixLabel: UILabel!
    @IBOutlet weak var addSubtractIceCubesToMixLabel: UILabel!
    //what i have
//    var money = 10
//    var lemons = 0
//    var iceCubes = 0
    //what i'll buy
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)//created our own init for this struct.
    let price = Price()
    
    var lemonToMix = 0
    var iceCubeToMix = 0
    var purchasedLemon = 1
    var purchasedIceCube = 1
    
    var weatherArray: [[Int]] = [[-10, -9, -5, -7], [5, 8, 10, 9], [22, 25, 27, 23]]
    var weatherToday = [0, 0, 0, 0]
    
    var weatherImageView: UIImageView = UIImageView(frame: CGRect(x: 20, y: 50, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(weatherImageView)
        self.updateInitialValue()
        self.simulateWeatherToday()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func buyLemon2Dollards(sender: UIButton) {
        
        if self.supplies.money <= 1{
            var alert = UIAlertController(title: "Warning", message: "You don't have enough Money to buy lemons.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            //var money = moneyAmountIHave.text?.toInt()
            //it took me a while to figure this out not feeling too good.
            if supplies.money >= 1 {
                
                supplies.money -= price.lemon
                supplies.lemons += 1
                purchasedLemon += 1
                updateInitialValue()
                
                //            buyReturnLemonsLabel.text = "\(lemons)"
                //            lemonAmountIHave.text = "\(lemons)" + " Lemons"
                //            moneyAmountIHave.text = "$" + "\(money)"
            }
            else {
                showAlertWithText(header: "Not Enough Credits", message: "You Lose")
            }
            
        }
        
    }
    
    @IBAction func returnLemon2Dollards(sender: UIButton) {
        
       if purchasedLemon > 0 {
        
        purchasedLemon -= 1
        supplies.lemons -= 1
        supplies.money += price.lemon
        updateInitialValue()
            //showAlertWithText(header: "You didn't purchase  a lemon yet", message: "Buy One")
//        money += lemonPrice
//        lemons -= 1
//        
//        buyReturnLemonsLabel.text = "\(lemons)"
//        lemonAmountIHave.text = "\(lemons)" + " Lemons"
//        moneyAmountIHave.text = "$" + "\(money)"
        
        }
       else {
        showAlertWithText(header: "You didn't purchase a lemon yet", message: "Might Want To Buy One")
        
        }
        
        
           }
    @IBAction func buyIceCubes1Dollard(sender: UIButton) {
        
        if supplies.money >= 1 {
            
            supplies.money -= price.iceCube
            supplies.iceCubes += 1
            purchasedIceCube += 1
            updateInitialValue()//if we don't call this function we'll have to assign the value to the label each time we need to update the value.
            
           
        }
             else {
                showAlertWithText(header: "Not Enough Credits", message: "You Lose")
            }
        
        
    }
    @IBAction func returnIceCube1Dollard(sender: UIButton) {
        if purchasedIceCube > 0 {
            //showAlertWithText(header: "You didn't purchase  a lemon yet", message: "Buy One")
           purchasedIceCube -= 1
           supplies.money += price.iceCube
           supplies.iceCubes -= 1
           updateInitialValue()
            
            
//            buyReturnIceCubesLabel.text = "\(iceCubes)"
//            iceCubeAmountIHave.text = "\(iceCubes)" + " Ice Cubes"
//            moneyAmountIHave.text = "$" + "\(money)"
            
        }
        else {
            showAlertWithText(header: "You didn't purchase Ice Cubes yet", message: "Might Want To Buy Some")
            
        }
    }
    @IBAction func addLemonsToMix(sender: UIButton) {
    
        if supplies.lemons >= 1 {
            
            supplies.lemons -= 1
            lemonToMix += 1
            purchasedLemon -= 1
            updateInitialValue()
//            for var addLemon = 0; addLemon <= lemons; addLemon++ {
//                var usedLemon = lemons - addLemon
//                addSubtractLemonsToMixLabel.text = "\(addLemon)"
//                lemonAmountIHave.text = "\(usedLemon)" + " Lemons"
//            }
        }
        
        else {
            showAlertWithText(header: "Not Enough Lemons", message: "You Lose")
        }
    }
    @IBAction func subtractLemonFromMix(sender: UIButton) {
        
        takeLemonFromMix()
    }
    @IBAction func addIceCubesToMix(sender: UIButton) {
        
        if supplies.iceCubes >= 1 {
            
            supplies.iceCubes -= 1
            iceCubeToMix += 1
            purchasedIceCube -= 1
            updateInitialValue()
//            for var addIce = 0; addIce <= iceCubes; addIce++ {
//                var usedIce = iceCubes - addIce
//                addSubtractIceCubesToMixLabel.text = "\(addIce)"
//                iceCubeAmountIHave.text = "\(usedIce)" + " Ice Cubes"
//            }
        }
            
        else {
            showAlertWithText(header: "Not Enough Ice Cubes", message: "You Lose")
        }
    }
    @IBAction func subtractIceCubesFromMix(sender: UIButton) {
        self.takeIceFromMix()
    }
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        //TODO:
        //implement when the user click on start day.
        let average = findAverage(weatherToday)
        
        let customer = Int(arc4random_uniform(UInt32(abs(average))))
        println("Customers: " + "\(customer)")

//          let lemonToMix = NSString (string: addSubtractLemonsToMixLabel.text!).doubleValue
//          let iceToMix = NSString(string: addSubtractIceCubesToMixLabel.text!).doubleValue
//        let ratio = lemonToMix / iceToMix
//        
        if lemonToMix == 0 || iceCubeToMix == 0 {
            showAlertWithText(header: "Warning", message: "You Need to add at least 1 lemon and 1 Ice")
        }
        
        else {
            let ratio = Double(lemonToMix) / Double(iceCubeToMix)
            
            for x in 0...customer {
                let preference = Double(arc4random_uniform(UInt32(101))) / 100
                
                if preference < 0.4 && ratio > 1 {
                    self.supplies.money += 1
                    //moneyAmountIHave.text = "$" + "\(self.supplies.money)"
                    println("Paid")
                }
                else if preference > 0.6 && ratio < 1{
                    supplies.money += 1
                   // moneyAmountIHave.text = "$" + "\(self.money)"
                    println("Paid")
                }
                else if preference <= 0.6 && preference >= 0.4 && ratio == 1{
                    supplies.money += 1
                   // moneyAmountIHave.text = "$" + "\(self.money)"
                    println("Paid")
                }
                else {
                    println("else statement evaluating")
                }
                
            }
            
            lemonToMix = 0
            iceCubeToMix = 0
            simulateWeatherToday()
            updateInitialValue()
           
            
        }
        
//        if customer == 0 {
//             showAlertWithText(header: "Sorry", message: "We're Close")
//        }
//        else {
//            
//        }
        
        
    }
    
    func updateInitialValue() {
        moneyAmountIHave.text = "$" + "\(self.supplies.money)"
        lemonAmountIHave.text = "\(self.supplies.lemons)" + " Lemons"
        iceCubeAmountIHave.text = "\(self.supplies.iceCubes)" + " Ice Cubes"
        
        buyReturnLemonsLabel.text = "\(purchasedLemon)"
        buyReturnIceCubesLabel.text = "\(purchasedIceCube)"
        
        addSubtractLemonsToMixLabel.text = "\(lemonToMix)"
        addSubtractIceCubesToMixLabel.text = "\(iceCubeToMix)"
  
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func takeLemonFromMix () {
        
        if lemonToMix > 0{
            
            lemonToMix -= 1
            supplies.lemons += 1
            purchasedLemon += 1
            updateInitialValue()
            
//            for var addedLemon = 5; addedLemon >= 0; --addedLemon {
//                //var noMixLemon = lemons + addedLemon
//            println(addedLemon)
//            //lemons += 1
//            lemonAmountIHave.text = "\(lemons)" + " Lemons"
            
            //addSubtractLemonsToMixLabel.text = "\(addedLemon)"
            
            }
            
        else {
            showAlertWithText(header: "You Returned All Your Lemons", message: "Thanks")
        }
    
        }
    
    func takeIceFromMix () {
        
        if iceCubeToMix > 0 {
            
            iceCubeToMix -= 1
            supplies.iceCubes += 1
            purchasedIceCube += 1
            updateInitialValue()
            
            
            //            for var addedIce = 10; addedIce >= 0; --addedIce {
            //
            //                iceCubeAmountIHave.text = "\(iceCubes)" + " Ice Cubes"
            //                addSubtractIceCubesToMixLabel.text  = "\(addedIce)"
            //            }
        }
            
        else {
            showAlertWithText(header: "You Returned All Your Ice Cubes", message: "Thanks")
        }
        
}
    
    func simulateWeatherToday () {
        
        let index = Int(arc4random_uniform(UInt32(weatherArray.count)))
        
        weatherToday = weatherArray[index]
        
        switch index {
        case 0:
            weatherImageView.image = UIImage(named: "Cold")
        case 1:
            weatherImageView.image = UIImage(named: "Mild")
        case 2:
            weatherImageView.image = UIImage(named: "Warm")
        default:
            weatherImageView.image = UIImage(named: "Warm")
        }
    }
    
    func findAverage(data: [Int]) -> Int {
        var sum = 0
        
        for x in data {
            sum += x
        }
        
        var average = Double(sum) / Double(data.count)//divides how many pieces of data by the sum.
        var rounded = Int(ceil(average))// ceil comes from the C language and is to round up to a possitive number.
        
        return rounded
    }
    
}
