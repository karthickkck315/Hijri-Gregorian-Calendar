//
//  CalenderPage.swift
//  Salaat
//
//  Created by Karthick on 5/10/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

struct Device {
  // iDevice detection code
  static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
  static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
  static let IS_RETINA           = UIScreen.main.scale >= 2.0
  
  static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
  static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
  static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
  static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
  
  static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
  static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
  static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
  static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
  static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
}

import UIKit

class CalenderPage: UIViewController,BSIslamicCalendarDelegate {
  
  var newCalendar = BSIslamicCalendar()
  var segmentControl = JTSegmentControl()
  var screenWidth : CGFloat = 0
  var screenHeight : CGFloat = 0
  var englishDateLabel = UILabel()
  var islamicDateLabel = UILabel()
  var scrollView = UIScrollView()
  
  var isIslamic = Bool()
  
  @IBOutlet weak var bgImagView: UIImageView!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.navigationController?.isNavigationBarHidden = true
   // self.tabBarController?.title = languageFile.calendar
    screenWidth = self.view.frame.size.width
    screenHeight = self.view.frame.size.height
    customization()
    }
  override func viewWillAppear(_ animated: Bool) {
      self.bgImagView.image = #imageLiteral(resourceName: "dayMode")
  }
  override func viewDidAppear(_ animated: Bool) {
    
    
 
  }
    
    func customization () {
        //  let navBarHeight = (self.navigationController?.navigationBar.intrinsicContentSize.height)! + UIApplication.shared.statusBarFrame.height
      
      
        let xPos : CGFloat = 20
        let yPos : CGFloat = UIApplication.shared.statusBarFrame.height+20
      
       var frame = CGRect(x: xPos, y: yPos, width: self.view.bounds.size.width - xPos*2, height: 45.0)
      if (Device.IS_IPHONE_X){
        frame = CGRect(x: xPos, y: yPos+20, width: self.view.bounds.size.width - xPos*2, height: 45.0)
      }
      
        
        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        
        segmentControl = JTSegmentControl(frame: frame)
        segmentControl.tag = 102
        segmentControl.delegate = self
      segmentControl.items = ["Gregorian","Hijri"]
        segmentControl.autoScrollWhenIndexChange = true
        segmentControl.backgroundColor = .clear
        segmentControl.itemBackgroundColor = UIColor.clear
        segmentControl.itemSelectedTextColor = UIColor.white
        segmentControl.itemTextColor = UIColor.white
        segmentControl.borderColor = .white
        segmentControl.font = UIFont.systemFont(ofSize: 25)
        segmentControl.selectedFont = UIFont.systemFont(ofSize: 25)
        segmentControl.borderWidth = 0.5
        segmentControl.sliderViewColor = UIColor.clear
        segmentControl.layer.cornerRadius = 0.5
        segmentControl.clipsToBounds = true
        segmentControl.itemSelectedBackgroundColor = UIColor.lightGray
        scrollView.addSubview(segmentControl)
        
        let yPosition = segmentControl.frame.size.height + segmentControl.frame.origin.y+10
        
        //English date
        englishDateLabel.frame = CGRect(x:xPos, y:yPosition ,width:screenWidth/2-20 ,height: 40)
        englishDateLabel.font = UIFont.systemFont(ofSize: 20)
        englishDateLabel.textAlignment = .center
        englishDateLabel.textColor = UIColor.white
        scrollView.addSubview(englishDateLabel)
        
        //islamic date
        islamicDateLabel.frame = CGRect(x:screenWidth/2, y:yPosition ,width:screenWidth/2-20 ,height: 40)
        islamicDateLabel.font = UIFont.systemFont(ofSize: 20)
        islamicDateLabel.textAlignment = .center
        islamicDateLabel.textColor = UIColor.white
        scrollView.addSubview(islamicDateLabel)
        
        //Get today date in english
        let dateFormatter = DateFormatter()
        let date = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        dateFormatter.dateFormat = "MMM yyyy"
        let dateString = "\(day!) \(dateFormatter.string(from: date))"
        englishDateLabel.text = dateString;
        
        //Get islamic or Hijiri Date format
        let hijri = Calendar(identifier: .islamic)
        dateFormatter.calendar = hijri
        dateFormatter.dateFormat = "d MMMM yyyy"
        let dateSt = dateFormatter.string(from: date)
        islamicDateLabel.text = dateSt
        
        setUpCalender()
    }
    
    
  //MARK:- Create Calendar
  func setUpCalender(){
    let yPosition = islamicDateLabel.frame.size.height + islamicDateLabel.frame.origin.y+10
    newCalendar = BSIslamicCalendar(frame: CGRect(x: 0, y: yPosition, width: view.frame.size.width, height: 355))
    newCalendar?.delegate = self
  //  newCalendar?.createGradientLayer()
    scrollView.addSubview(newCalendar!)
    newCalendar?.setIslamicDatesInArabicLocale(false)
    newCalendar?.setShowIslamicMonth(false)
    
    scrollView.contentSize = CGSize(width: screenWidth, height: (newCalendar?.frame.origin.y)!+(newCalendar?.frame.size.height)!+50)
  }
  //MARK: Set retrun based on date
  func islamicCalendar(_ calendar: BSIslamicCalendar!, shouldSelect date: Date!) -> Bool {
    if calendar.compare(date, with: Date()) {
      return false
    } else {
      return true
    }
    
  }
  
  //MARK: - calender selected delegate method
  func islamicCalendar(_ calendar: BSIslamicCalendar!, dateSelected date: Date!, withSelectionArray selectionArry: [Any]!) {
    print("selections: \(selectionArry)")
    
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension CalenderPage : JTSegmentControlDelegate {
  func didSelected(segement: JTSegmentControl, index: Int) {
    print("current index \(index)")
    segement.showBridge(show: false, index: index)
    if index == 0{
      newCalendar?.setIslamicDatesInArabicLocale(false)
      newCalendar?.setShowIslamicMonth(false)
    }else if index == 1 {
      newCalendar?.setIslamicDatesInArabicLocale(true)
      newCalendar?.setShowIslamicMonth(true)
    }
  }
}
