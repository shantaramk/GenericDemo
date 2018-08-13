//
//  animationViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/3/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class animationViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var area: Int {
        get {
            return 10
        }
        set {
            self.area = newValue * 10
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGUI()
    }
    func setupGUI() {
        button.layer.cornerRadius =  button.frame.height / 2
        button.backgroundColor = UIColor.red
        button.layer.borderColor = UIColor.black.cgColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonClick(_ sender: Any) {
        self.startAnimation()
    }
    func startAnimation() {
    let duration = 2.0
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                //1.Expansion + button label alpha
                self.button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                //2.Shrink
                self.button.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                //3.Grant momentum : LEFT
                let x = self.button.frame.origin.x
                self.button.frame.origin.x = x - 40
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                //4.Move out of screen and reduce alpha to 0
                self.button.frame.origin.x = self.view.frame.width
                self.button.alpha = 0.0
            })
            
        }) { (completed) in
            print("Completion of whole animation sequence")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension animationViewController {
    //public var myName: String = ""
    func callME() {
        print("call me")
    }
}
