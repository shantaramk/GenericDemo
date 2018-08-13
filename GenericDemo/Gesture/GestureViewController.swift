//
//  GestureViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/8/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class GestureViewController: UIViewController {

    // MARKS: - Properties
    var swipeView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSwipeGesture()
    }
    func initWithPopScreen() -> UIView {
        let view = UIView()
        let frame = self.view.frame
        view.frame = frame
        view.frame.origin.x = frame.width
        view.backgroundColor = UIColor.red
        return view
    }
    func addSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped Right")
                hideScreen()
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped Left")
                showScreen()
            default:
                break
            }
        }
    }
    func showScreen() {
        swipeView = self.initWithPopScreen()
        self.view.addSubview(self.swipeView!)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = .right
        swipeView?.addGestureRecognizer(swipeRight)
         UIView.animate(withDuration: 0.8) {
            self.swipeView?.frame.origin.x = self.view.frame.origin.x + 30
        }
    }
    func hideScreen() {
    
        UIView.animate(withDuration: 0.8, animations: {
            self.swipeView?.frame.origin.x = self.view.frame.width

        }) { (completed) in
            self.swipeView!.removeFromSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
