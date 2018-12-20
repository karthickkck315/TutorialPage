//
//  PagingVC.swift
//  TutorialPage
//
//  Created by Karthick on 5/15/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit
import StoreKit
import AVFoundation

class PagingVC: UIViewController,UIScrollViewDelegate {
  
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var scrollView:UIScrollView!
    
  let imagelist = ["image1", "image2", "image3", "image4"]
  var pageControl : UIPageControl = UIPageControl()
  var screenWidth = CGFloat()
  var screenHeight = CGFloat()
  var skipButton = UIButton()
  var nextButton = UIButton()
  
  var avPlayer: AVPlayer!
  var avPlayerLayer: AVPlayerLayer!
  var paused: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.isNavigationBarHidden = true
    screenHeight = UIScreen.main.bounds.size.height
    screenWidth = UIScreen.main.bounds.size.width
    

    pageControl = UIPageControl(frame: CGRect(x: screenWidth/2-screenWidth/4, y: screenHeight-80, width: screenWidth/2, height: 50))
    scrollView.delegate = self
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.bounces = true
    scrollView.isScrollEnabled = false
   // scrollView.backGroundColor = UIColor.appBGAlphaColor
    self.view.addSubview(scrollView)
    
    //Skip button
    skipButton = UIButton()
    skipButton.frame = CGRect(x:20 , y: screenHeight-80, width: 70, height: 35)
    skipButton.setTitle("Hopp over", for: .normal)
    //skipButton.titleLabel?.font = UIFont.regularFont12
    //skipButton.layer.borderWidth = 1.0
    //skipButton.layer.borderColor = UIColor.appWhiteColor.cgColor
    //skipButton.cornerRadius = skipButton.frame.size.height/2
    skipButton.clipsToBounds = true
    //skipButton.backgroundColor = UIColor.lightOrange
    //skipButton.setTitleColor(UIColor.lightOrange, for: .normal)
   // skipButton.addTarget(self, action: #selector(moveToDashBoard), for: .touchUpInside)
    self.view.addSubview(skipButton)

    //Descrption
    nextButton = UIButton()
    nextButton.frame = CGRect(x:screenWidth-90 , y: screenHeight-80, width: 70, height: 35)
    nextButton.setTitle("Neste", for: .normal)
   // nextButton.titleLabel?.font = UIFont.regularFont12
    //nextButton.layer.borderWidth = 1.0
   // nextButton.layer.borderColor = UIColor.appWhiteColor.cgColor
   // nextButton.cornerRadius = skipButton.frame.size.height/2
    nextButton.clipsToBounds = true
    //nextButton.backgroundColor = UIColor.lightOrange
   // nextButton.setTitleColor(UIColor.lightOrange, for: .normal)
    nextButton.addTarget(self, action: #selector(moveToNextPage), for: .touchUpInside)
    self.view.addSubview(nextButton)
    
    //PAge control
    configurePageControl()
    for  i in stride(from: 0, to: imagelist.count, by: 1) {
      self.scrollView.isPagingEnabled = true
      let myImage:UIImage = UIImage(named: imagelist[i])!
      let myImageView:UIImageView = UIImageView()
      //myImageView.isHidden = true
      myImageView.image = myImage
      // myImageView.contentMode = UIViewContentMode.scaleAspectFit
      myImageView.frame = CGRect(x: self.scrollView.frame.size.width * CGFloat(i), y: 0, width: screenWidth, height: screenHeight)
      scrollView.addSubview(myImageView)
    }
    self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * CGFloat(imagelist.count), height: UIScreen.main.bounds.size.height)
    
    Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    
  }
@objc func moveToNextPage () {
       
        let pageNumber = round(self.scrollView.contentOffset.x / self.scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber+1)
        
        if Int(pageNumber+1) == 3 {
           nextButton.setTitle("KjØr", for: .normal)
        }
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(imagelist.count)
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
            pageControl.currentPage = 0
           // moveToDashBoard()
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    
    }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
   }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
  }
  
  func configurePageControl() {
    self.pageControl.numberOfPages = imagelist.count
    self.pageControl.currentPage = 0
    self.pageControl.tintColor = UIColor.red
    self.pageControl.pageIndicatorTintColor = UIColor.black
   // self.pageControl.currentPageIndicatorTintColor = UIColor.lightOrange
    self.view.addSubview(pageControl)
  }
  
  // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
  func changePage(sender: AnyObject) -> () {
    let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
    scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    pageControl.currentPage = Int(pageNumber)
    print(imagelist.count)
    print(Int(pageNumber))
    if imagelist.count-1 == Int(pageNumber) {
      //moveToDashBoard()
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

