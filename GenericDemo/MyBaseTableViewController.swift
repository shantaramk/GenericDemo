//
//  MyBaseTableViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/2/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

enum LoginError : Error {
    case emptyForm
}
struct TaskList {
    static let addSubView = "Popup : Add SubView"
    static let presentView = "Popup : PresentView"
    static let addChildViewController = "Popup : addChildViewController"
    static let animateKeyFrames = "Animation : Animatekeyframes"
    static let sqlite = "Sqlite"
    static let Gesture = "Swap Gesture"
    static let Segment = "Custom Segment"
    static let PageViewController = "Page ViewController"

 
}
class MyBaseTableViewController: UITableViewController {
    
    //MARK: - Properties
    let titleList = [TaskList.addSubView,TaskList.presentView,TaskList.addChildViewController,TaskList.animateKeyFrames,TaskList.sqlite,TaskList.Gesture,TaskList.Segment,TaskList.PageViewController]
    public typealias handler_Name = (String)->Void
    override func viewDidLoad() {
        super.viewDidLoad()
setHeaderView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        do {
            var name = "sd"
            let d = try login(&name, handler: { (name) in
                print(name)

            })
            print(d)
        } catch LoginError.emptyForm {
            print("Number is Even")
        }
        catch let unKnownError {
            print("unKnownError is Even")

        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    func login(_ userName : inout String,handler : @escaping handler_Name) throws -> String {
        if userName == "" {
            throw LoginError.emptyForm
        }
    handler("handler ocmplted")
        return "completed login"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setHeaderView() {
        if let view = Bundle.main.loadNibNamed("customTableHeaderView", owner: nil, options: nil)?.first as? customTableHeaderView {
            self.tableView.tableHeaderView = view
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = titleList[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToViewController(titleList[indexPath.row])
    }
    func navigateToViewController(_ title: String) {
        //    let titleList = [TaskList.addSubView,TaskList.presentView,TaskList.addChildViewController,TaskList.animateKeyFrames]
         if title == TaskList.animateKeyFrames {
            let vc = animationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
         }
         else if title == TaskList.addChildViewController {
            let vc = popView()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
         else if title == TaskList.presentView {
            let vc = popView()
            guard let content = vc.view else { return }
            self.addChildViewController(vc)
            content.frame = UIScreen.main.bounds
            self.tableView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
         else if title == TaskList.presentView {
            let vc = popView().view
            guard let content = vc else { return }
            content.frame = self.tableView.bounds
            content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.tableView.addSubview(content)
        }
         else if title == TaskList.sqlite {
              self.navigationController?.pushViewController(StudentViewController(), animated: true)
         }
         else if title == TaskList.Gesture {
            self.navigationController?.pushViewController(GestureViewController(), animated: true)
        }
         else if title == TaskList.Segment {
            self.navigationController?.pushViewController(segmentViewController(), animated: true)
        }
         else if title == TaskList.PageViewController {
            self.navigationController?.pushViewController(PageBaseViewController(), animated: true)
        }
 
    }
}
class ChildTableVC: MyBaseTableViewController {
    override func viewDidLoad() {
    }
}
