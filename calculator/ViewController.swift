//
//  ViewController.swift
//  calculator
//
//  Created by 向ivy on 16/3/11.
//  Copyright © 2016年 Meiyi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var output:UILabel!
    enum Operation:String{
        case Divide="/"
        case Multiply="*"
        case Plus="+"
        case Minus="-"
        case Empty="Empty"}
    
    var btnSound: AVAudioPlayer!
    var bttnSound: AVAudioPlayer!
    var clearSound:AVAudioPlayer!
    var numb=""
    var leftNum=""
    var rightNum=""
    var result=""
    var currentOperation:Operation=Operation.Empty
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path =
        NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let pathh =
        NSBundle.mainBundle().pathForResource("bttn", ofType: "wav")
        
        let pathp=NSBundle.mainBundle().pathForResource("bbb", ofType: "wav")
        
        let soundPUrl=NSURL(fileURLWithPath: pathp!)
        let soundUrl = NSURL(fileURLWithPath: path!)
        let soundsUrl=NSURL(fileURLWithPath: pathh!)
        
        do{
           try clearSound=AVAudioPlayer(contentsOfURL: soundPUrl)
           try btnSound=AVAudioPlayer(contentsOfURL: soundUrl)
           try bttnSound=AVAudioPlayer(contentsOfURL: soundsUrl)
        }catch let err as NSError{
        print(err.debugDescription)
        }
        
    }

    @IBAction func numPress(btn: UIButton!){
        btnSound.play()
        numb+="\(btn.tag)"
        output.text=numb
    
    }
    @IBAction func clearance(bbb: UIButton!) {
        clearSound.play()
        leftNum=""
        rightNum=""
        numb=""
        output.text="0"
        currentOperation=Operation.Empty
    }
    @IBAction func signPress(bttn: UIButton!){
      bttnSound.play()
    }
    
    @IBAction func minusPress(sender: AnyObject) {
        precess(Operation.Minus)
    }
    @IBAction func dividePress(sender: AnyObject) {
        precess(Operation.Divide)
    }
    @IBAction func multiPress(sender: AnyObject) {
        precess(Operation.Multiply)
    }
    @IBAction func plusPress(sender: AnyObject) {
        precess(Operation.Plus)
    }
    @IBAction func equalPress(sender: AnyObject) {
        precess(currentOperation)
    }
    
    func precess (op:Operation){
        
        if(currentOperation != Operation.Empty){
            
            if(numb != ""){
                rightNum=numb
                numb=""
            if(currentOperation==Operation.Multiply){
             result="\(Double(rightNum)! * Double(leftNum)!)"
            }else if(currentOperation==Operation.Divide){
             result="\(Double(rightNum)! / Double(leftNum)!)"
            }else if(currentOperation==Operation.Plus){
             result="\(Double(rightNum)! + Double(leftNum)!)"
            }else if(currentOperation==Operation.Minus){
             result="\(Double(leftNum)! - Double(rightNum)!)"
            }
            leftNum=result
            output.text=result
            }
            currentOperation=op
            
        }else{
        leftNum=numb
        numb=""
        currentOperation=op
        }
        
    }
}

