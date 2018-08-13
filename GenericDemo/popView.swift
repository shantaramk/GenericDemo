



//
//  popView.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/2/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class popView: UIViewController {

    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showAnimation() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 1.25) {
            self.view.alpha = 1.0
             self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    @IBAction func closeAction(_ sender: Any) {
   
      
        self.myView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.view.alpha = 1.0
        UIView.animate(withDuration: 1.25) {
            self.view.alpha = 0.0
            self.myView.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.hideContentController(content: self)

        }
        
//
    }
    func hideContentController(content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
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
