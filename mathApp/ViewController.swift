//
//  ViewController.swift
//  mathApp
//
//  Created by Shivang Dave on 2/14/17.
//  Copyright © 2017 Shivang Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var segControl1 : UISegmentedControl!
    @IBOutlet weak var segControl2 : UISegmentedControl!
    
    @IBOutlet weak var lblValA : UILabel!
    @IBOutlet weak var txtVala : UITextField!
    
    @IBOutlet weak var lblValB : UILabel!
    @IBOutlet weak var txtValb : UITextField!
    
    @IBOutlet weak var lblValC : UILabel!
    @IBOutlet weak var txtValc : UITextField!
    
    @IBOutlet weak var lblValD : UILabel!
    @IBOutlet weak var txtVald : UITextField!

    @IBOutlet weak var lblRoots : UILabel!
    @IBOutlet weak var lblDerivative : UILabel!
    
    @IBOutlet weak var btnCalc : UIButton!
    
    @IBOutlet weak var subView : UIView!
    
    //MARK: Declarations
    let nf = NumberFormatter()
    var rootArray = [Double]()
    var fvalueArray = [Double]()
    var fdvalueArray = [Double]()
    var solved = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        subView.isHidden = true
        txtVala.becomeFirstResponder()
        
        btnCalc.layer.cornerRadius = 20
        btnCalc.backgroundColor = UIColor(colorLiteralRed: 89.0/255, green: 89.0/255, blue: 89.0/255, alpha: 1.0)
        btnCalc.layer.borderWidth = 2
        btnCalc.layer.borderColor = UIColor(colorLiteralRed: 89.0/255, green: 89.0/255, blue: 89.0/255, alpha: 1.0).cgColor
        
        checkSeg()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions & Methods
    
    func helpPopup()
    {
        subView.isHidden = !subView.isHidden
    }
    
    @IBAction func segOneClicked(_ sender: Any)
    {
        clearAll()
        checkSeg()
    }
    
    @IBAction func segTwoClicked(_ sender: Any)
    {
        clearAll()
        checkSeg()
    }
    
    @IBAction func btnCalcClicked(_ sender: Any)
    {
        self.view.endEditing(true)
        
        if validation()
        {
            if segControl2.selectedSegmentIndex == 0
            {
                switch segControl1.selectedSegmentIndex {
                case 0:
                    linear()
                    break
                case 1:
                    quad()
                    break
                case 2:
                    cubic()
                    break
                default:
                    break
                }
            }
            else
            {
                switch segControl1.selectedSegmentIndex {
                case 0:
                    linearEq()
                    break
                case 1:
                    quadEq()
                    break
                case 2:
                    cubicEq()
                    break
                default:
                    break
                }
            }
        }
        else
        {
            lblRoots.text = ""
            lblDerivative.text = ""
        }
    }

    
    //MARK: Linear
    
    func linearEq()
    {
        let string = txtVala.text!
        
        if string.contains("+")
        {
            let sep = string.components(separatedBy: "+")
            let a = nf.number(from: sep[0].components(separatedBy: "x")[0])?.intValue
            let b = nf.number(from: sep[1])?.intValue
            lblDerivative.text = "Derivation(s):\n" + "F'(x): \(a!)"
            
            let sol = -Double(b!)/Double(a!)
            lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",sol)
            
        }
        else if string.contains("-")
        {
            if string.hasPrefix("-")
            {
                txtVala.text = ""
                helpPopup()
                lblRoots.text = ""
                lblDerivative.text = ""
            }
            else
            {
                let sep = string.components(separatedBy: "-")
                let a = nf.number(from: sep[0].components(separatedBy: "x")[0])?.intValue
                let b = nf.number(from: sep[1])?.intValue
                lblDerivative.text = "Derivation(s):\n" + "F'(x): \(a!)"
                
                let sol = Double(b!)/Double(a!)
                lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",sol)
            }
            
        }
        clearAll()
    }
    
    func linear()
    {
        if (nf.number(from: txtValb.text!)?.intValue)! < 0
        {
            lblDerivative.text = "Derivation(s):\n" + "F'(x): \(txtVala.text!)"
            if (txtValb.text?.contains("-"))!
            {
                let x = nf.number(from: txtVala.text!)?.intValue
                let y = nf.number(from: txtValb.text!)?.intValue
                
                answer(x: x!, y: y!, minus: true)
            }
            else
            {
                let x = nf.number(from: txtVala.text!)?.intValue
                let y = nf.number(from: txtValb.text!)?.intValue
                
                answer(x: x!, y: y!, minus: false)
            }
        }
        else
        {
            lblDerivative.text = "Derivation(s):\n" + "F'(x): \(txtVala.text!)"
            if (txtVala.text?.contains("-"))!
            {
                let x = nf.number(from: txtVala.text!)?.intValue
                let y = nf.number(from: txtValb.text!)?.intValue
                
                answer(x: x!, y: y!, minus: false)
            }
            else
            {
                let x = nf.number(from: txtVala.text!)?.intValue
                let y = nf.number(from: txtValb.text!)?.intValue
                
                answer(x: x!, y: y!, minus: true)
            }
        }
        clearAll()
    }
    
    func answer(x:Int,y:Int,minus:Bool)
    {
        if minus
        {
            if (txtVala.text?.contains("-"))!
            {
                let solution = Double(-y)/Double(x)
                lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",solution)
            }
            else
            {
                let solution = Double(-y)/Double(x)
                lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",solution)
            }
        }
        else
        {
            if (txtVala.text?.contains("-"))!
            {
                let solution = Double(-y)/Double(x)
                lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",solution)
            }
            else{
                let solution = Double(y)/Double(x)
                lblRoots.text = "Root(s): \n" + String(format:"x = %0.1f",solution)
            }
        }
    }
    
    //MARK: Quad
    
    func quadEq()
    {
        let string = txtVala.text!
        
        if string.hasPrefix("-") || string.contains("-")
        {
            txtVala.text = ""
            helpPopup()
            lblRoots.text = ""
            lblDerivative.text = ""
        }
        else
        {
            let sep = string.components(separatedBy: "+")
            
            let a = (nf.number(from: sep[0].components(separatedBy: "x^2")[0])?.doubleValue)!
            let b = (nf.number(from: sep[1].components(separatedBy: "x")[0])?.doubleValue)!
            let c = (nf.number(from: sep[2])?.doubleValue)!
            
            let squareb = b * b
            let d = squareb - (4 * a * c)
            let isImaginary = d < 0
            let dsqrt = sqrt(fabs(d))
            
            if isImaginary
            {
                lblRoots.text = "Root(s): \n" + "x = " + "\(-b)+" + String(format:"%0.1f",dsqrt) + "i/\(2*a) & x = " + "\(-b)-" + String(format:"%0.1f",dsqrt) + "i/\(2*a)"
                
            }
            else
            {
                let up = -b + dsqrt
                let down = 2 * a
                let root = up / down
                
                let upTwo = -b - dsqrt
                let root2 = upTwo / down
                
                lblRoots.text = "Root(s): \n" + "x = " + String(format:"%0.1f",root) + " & x = " + String(format:"%0.1f",root2)
            }
            
            var firstDer = ""
            
            if b<0
            {
                firstDer = "F'(x): \(2*a)x\(b)"
            }
            else
            {
                firstDer = "F'(x): \(2*a)x+\(b)"
            }
            
            let secondDer = "F''(x): \(2*a)"
            
            lblDerivative.text = "Derivation(s):\n" + firstDer + "\n" + secondDer
        }
        
        clearAll()
        
    }
    
    func quad()
    {
        let a = Double(txtVala.text!)!
        let b = Double(txtValb.text!)!
        let c = Double(txtValc.text!)!
        let squareb = b * b
        let d = squareb - (4 * a * c)
        let isImaginary = d < 0
        let dsqrt = sqrt(fabs(d))
        
        if isImaginary
        {
            lblRoots.text = "Root(s): \n" + "x = " + "\(-b)+" + String(format:"%0.1f",dsqrt) + "i/\(2*a) & x = " + "\(-b)-" + String(format:"%0.1f",dsqrt) + "i/\(2*a)"
        }
        else
        {
            let up = -b + dsqrt
            let down = 2 * a
            let root = up / down
            
            let upTwo = -b - dsqrt
            let root2 = upTwo / down
            
            lblRoots.text = "Root(s): \n" + "x = " + String(format:"%0.1f",root) + " & x = " + String(format:"%0.1f",root2)
        }
        
        var firstDer = ""
        if b<0
        {
            firstDer = "F'(x): \(2*a)x\(b)"
        }
        else
        {
            firstDer = "F'(x): \(2*a)x+\(b)"
        }
        
        let secondDer = "F''(x): \(2*a)"
        
        lblDerivative.text = "Derivation(s):\n" + firstDer + "\n" + secondDer
        
        clearAll()
    }
    
    //MARK: Cubic
    
    func cubicEq()
    {
        let string = txtVala.text!
        
        if string.hasPrefix("-") || string.contains("-")
        {
            txtVala.text = ""
            helpPopup()
            lblRoots.text = ""
            lblDerivative.text = ""
        }
        else
        {
            let sep = string.components(separatedBy: "+")
            
            let a = (nf.number(from: sep[0].components(separatedBy: "x^3")[0])?.doubleValue)!
            let b = (nf.number(from: sep[1].components(separatedBy: "x^2")[0])?.doubleValue)!
            let c = (nf.number(from: sep[2].components(separatedBy: "x")[0])?.doubleValue)!
            let d = (nf.number(from: sep[3])?.doubleValue)!
            
            let firstDer = "F'(x): \(3*a)x²+\(2*b)x+\(c)"
            
            let secondDer = "F''(x): \(6*a)x+\(2*b)"
            
            let thirdDer = "F'''(x): \(6*a)"
            
            lblDerivative.text = "Derivation(s):\n" + firstDer + "\n" + secondDer + "\n" + thirdDer
            
            if !solved
            {
                for i in 0...10
                {
                    var firstX = Double()
                    var baseValue = Double()
                    var derValue = Double()
                    
                    if i == 0
                    {
                        if b < 0
                        {
                            firstX = b
                        }
                        else
                        {
                            firstX = -b
                        }
                        
                        baseValue = (a*firstX*firstX*firstX) + (b*firstX*firstX) + (c*firstX) + d
                        
                        derValue = (3.0*a*firstX*firstX) + (2.0*b*firstX) + c
                        
                        rootArray.append(firstX)
                        fvalueArray.append(baseValue)
                        fdvalueArray.append(derValue)
                    }
                    else
                    {
                        firstX = rootArray[i-1] - fvalueArray[i-1] / fdvalueArray[i-1]
                        
                        baseValue = (a*firstX*firstX*firstX) + (b*firstX*firstX) + (c*firstX) + d
                        
                        derValue = (3.0*a*firstX*firstX) + (2.0*b*firstX) + c
                        
                        rootArray.append(firstX)
                        fvalueArray.append(baseValue)
                        fdvalueArray.append(derValue)
                        
                        if String(format:"%0.4f",fdvalueArray[i]) == String(format:"%0.4f",fdvalueArray[i-1])
                        {
                            lblRoots.text = "Root(s): \n" + "x = " + String(format:"%0.4f",rootArray[i])
                            solved = true
                            break
                        }
                        
                    }
                    
                }
            }
            
            clearAll()
        }
    }
    
    func cubic()
    {
        let a = Double(txtVala.text!)!
        let b = Double(txtValb.text!)!
        let c = Double(txtValc.text!)!
        let d = Double(txtVald.text!)!
        
        var firstDer = ""
        var secondDer = ""
        
        if b<0 && c>0
        {
            firstDer = "F'(x): \(3*a)x²\(2*b)x+\(c)"
            
            secondDer = "F''(x): \(6*a)x\(2*b)"
        }
        else if b>0 && c<0
        {
            firstDer = "F'(x): \(3*a)x²+\(b)x\(c)"
            
            secondDer = "F''(x): \(6*a)x+\(2*b)"
        }
        else if b<0 && c<0
        {
            firstDer = "F'(x): \(3*a)x²\(b)x\(c)"
            
            secondDer = "F''(x): \(6*a)x\(2*b)"
        }
        else
        {
            firstDer = "F'(x): \(3*a)x²+\(2*b)x+\(c)"
            
            secondDer = "F''(x): \(6*a)x+\(2*b)"
        }
        
        let thirdDer = "F'''(x): \(6*a)"
        
        lblDerivative.text = "Derivation(s):\n" + firstDer + "\n" + secondDer + "\n" + thirdDer
        
        if !solved
        {
            for i in 0...10
            {
                var firstX = Double()
                var baseValue = Double()
                var derValue = Double()
                
                if i == 0
                {
                    if b < 0
                    {
                        firstX = b
                    }
                    else
                    {
                        firstX = -b
                    }
                    
                    baseValue = (a*firstX*firstX*firstX) + (b*firstX*firstX) + (c*firstX) + d
                    
                    derValue = (3.0*a*firstX*firstX) + (2.0*b*firstX) + c
                    
                    rootArray.append(firstX)
                    fvalueArray.append(baseValue)
                    fdvalueArray.append(derValue)
                }
                else
                {
                    firstX = rootArray[i-1] - fvalueArray[i-1] / fdvalueArray[i-1]
                    
                    baseValue = (a*firstX*firstX*firstX) + (b*firstX*firstX) + (c*firstX) + d
                    
                    derValue = (3.0*a*firstX*firstX) + (2.0*b*firstX) + c
                    
                    rootArray.append(firstX)
                    fvalueArray.append(baseValue)
                    fdvalueArray.append(derValue)
                    
                    if String(format:"%0.4f",fdvalueArray[i]) == String(format:"%0.4f",fdvalueArray[i-1])
                    {
                        lblRoots.text = "Root(s): \n" + "x = " + String(format:"%0.4f",rootArray[i])
                        solved = true
                        break
                    }
                    
                }
                
            }
            solved = false
        }
        
        clearAll()
    }
    
    //MARK: TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.keyboardType = .numbersAndPunctuation
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var notAllowed = ""
        
        if segControl2.selectedSegmentIndex == 0
        {
            notAllowed = "=abcdefghijklmnopqrstuvwxyz "
        }
        else
        {
            if segControl1.selectedSegmentIndex == 0
            {
                notAllowed = "=abcdefghijklmnopqrstuvwyz "
            }
            else if segControl1.selectedSegmentIndex == 1
            {
                notAllowed = "=abcdefghijklmnopqrstuvwz "
            }
            else if segControl1.selectedSegmentIndex == 2
            {
                notAllowed = "=abcdefghijklmnopqrstuvw "
            }
        }
        
        if string.isEmpty{
            return true
        }
        
        let set = NSCharacterSet(charactersIn: notAllowed)
        let inverted = set.inverted
        let filter = string.components(separatedBy: inverted).joined(separator: "")
        
        return filter != string
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtVala)
        {
            if segControl2.selectedSegmentIndex < 1
            {
                txtVala.resignFirstResponder()
                txtValb.becomeFirstResponder()
            }
            else
            {
                self.view.endEditing(true)
                txtVala.resignFirstResponder()
            }
        }
        else if(textField == txtValb)
        {
            if segControl1.selectedSegmentIndex == 0
            {
                txtValb.resignFirstResponder()
                self.view.endEditing(true)
            }
            else
            {
                txtValb.resignFirstResponder()
                txtValc.becomeFirstResponder()
            }
            
        }
        else if(textField == txtValc)
        {
            if segControl1.selectedSegmentIndex == 1
            {
                self.view.endEditing(true)
                txtValc.resignFirstResponder()
            }
            else
            {
                txtValc.resignFirstResponder()
                txtVald.becomeFirstResponder()
            }
        }
        else
        {
            txtVald.resignFirstResponder()
        }
        return false
    }
    
    //MARK: Validation & Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
        txtVala.resignFirstResponder()
        txtValb.resignFirstResponder()
        txtValc.resignFirstResponder()
        txtVald.resignFirstResponder()
    }
    
    func validation() -> Bool
    {
        if segControl2.selectedSegmentIndex == 0
        {
            if segControl1.selectedSegmentIndex == 0
            {
                if txtVala.text?.characters.count == 0 || txtValb.text?.characters.count == 0
                {
                    alertShow()
                    return false
                }
            }
            else if segControl1.selectedSegmentIndex == 1
            {
                if txtVala.text?.characters.count == 0 || txtValb.text?.characters.count == 0 || txtValc.text?.characters.count == 0
                {
                    alertShow()
                    return false
                }
            }
            else if segControl1.selectedSegmentIndex == 2
            {
                if txtVala.text?.characters.count == 0 || txtValb.text?.characters.count == 0 || txtValc.text?.characters.count == 0 || txtVald.text?.characters.count == 0
                {
                    alertShow()
                    return false
                }
            }
        }
        else
        {
            if txtVala.text?.characters.count == 0
            {
                alertShow()
                return false
            }
        }
        return true
    }
    
    func hideAllExceptA()
    {
        lblValA.text = "Enter equation:"
        lblValB.isHidden = true
        lblValC.isHidden = true
        lblValD.isHidden = true
        txtValb.isHidden = true
        txtValc.isHidden = true
        txtVald.isHidden = true
    }
    
    @IBAction func btnDismissClicked(_ sender: Any)
    {
        subView.isHidden = true
    }
    
    //MARK: Alert views
    
    func alertShow()
    {
        let alert = UIAlertController(title: "Error", message: "Field(s) are empty!!", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearAll()
    {
        txtVala.text = ""
        txtValb.text = ""
        txtValc.text = ""
        txtVald.text = ""
    }
    
    //MARK: Seg Functions
    
    func checkSeg()
    {
        self.view.endEditing(true)
        switch segControl1.selectedSegmentIndex
        {
        case 0:
            if segControl2.selectedSegmentIndex < 1
            {
                lblValA.text = "Enter value of a:"
                lblValC.isHidden = true
                lblValD.isHidden = true
                lblValB.isHidden = false
                txtValb.isHidden = false
                txtValc.isHidden = true
                txtVald.isHidden = true
            }
            else
            {
                hideAllExceptA()
            }
            break
        case 1:
            if segControl2.selectedSegmentIndex < 1
            {
                lblValA.text = "Enter value of a:"
                lblValB.isHidden = false
                txtValb.isHidden = false
                txtValc.isHidden = false
                lblValC.isHidden = false
                lblValD.isHidden = true
                txtVald.isHidden = true
            }
            else
            {
                hideAllExceptA()
            }
            break
        case 2:
            if segControl2.selectedSegmentIndex < 1
            {
                lblValA.text = "Enter value of a:"
                lblValB.isHidden = false
                txtValb.isHidden = false
                lblValC.isHidden = false
                lblValD.isHidden = false
                txtValc.isHidden = false
                txtVald.isHidden = false
            }
            else
            {
                hideAllExceptA()
            }
            break
        default:
            break
        }
    }

}
