//
//  PageBaseViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class PageBaseViewController: UIViewController,UIScrollViewDelegate {
    // MARK: - Properties
    private var pageController: UIPageViewController!
    var controllerList = [UIViewController]()
    private var currentPage: Int!
    // MARK: - Outlet
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    // MARK: - ViewControoler
    lazy var vc1: VC1 = {
        let storyborad = UIStoryboard(name: "PageViewBorad", bundle: nil)
        if var viewController = storyborad.instantiateViewController(withIdentifier: "VC1") as? VC1 {
            return viewController
        }
        return VC1()
    }()
    lazy var vc2: VC2 = {
        let storyborad = UIStoryboard(name: "PageViewBorad", bundle: nil)
        if let viewController: VC2 = storyborad.instantiateViewController(withIdentifier: "VC2") as? VC2 {
            return viewController
         }
        return VC2()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentPage = 0
        setupPageViewController()
        setupSegmentControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Setup
    func setupPageViewController() {
        controllerList.append(vc1)
        controllerList.append(vc2)
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        //set Scroll view delegate
        if let subViews = pageController.view.subviews as? [UIScrollView] {
            for scrollview in subViews {
                scrollview.delegate = self
            }
        }
        pageController.delegate = self
        pageController.dataSource = self
        self.pageController.view.frame = CGRect(x: 0, y: self.segmentedControl.frame.maxY + 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        pageController.setViewControllers([controllerList[currentPage]], direction: .forward, animated: true, completion: nil)
        //Add subViewController
        self.addChildViewController(pageController) //Main child and parent relation
        self.view.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
    }
    func setupSegmentControl() {
        segmentedControl.commaSeperatedButtonTitles = "Ongoing, History"
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
        self.segmentedControl.updateSegmentedControlSegs(index: currentPage)

    }
    // MARK: - Action
    @objc func onChangeOfSegment(_ sender: CustomSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            pageController.setViewControllers([controllerList[0]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
            currentPage = 0
        case 1:
            if currentPage > 1 {
                pageController.setViewControllers([controllerList[1]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
                currentPage = 1
            } else {
                pageController.setViewControllers([controllerList[1]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                currentPage = 1
            }
        default:
            break
        }
    }
}
extension PageBaseViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index: Int = indexofviewController(viewCOntroller: viewController)
        if index != -1 {
            index -= 1
        }
        if index < 0 {
            return nil
        } else {
            return controllerList[index]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexofviewController(viewCOntroller: viewController)
        if index != -1 {
            index += 1
        }
        if index >= controllerList.count {
            return nil
        } else {
            return controllerList[index]
        }
    }
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if controllerList .contains(viewCOntroller) {
            return controllerList.index(of: viewCOntroller)!
        }
            return -1
    }
}
extension PageBaseViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
         if completed {
            currentPage = controllerList.index(of: (pageViewController1.viewControllers?.last)!)
            // self.segmentedControl.selectedSegmentIndex = currentPage
             self.segmentedControl.updateSegmentedControlSegs(index: currentPage)
        }
    }
}
