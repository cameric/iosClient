//
//  ScheduleViewController.swift
//  iosClient
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import JTCalendar

/*class CalendarDelegateManager: JTCalendarDelegateManager {
    override func prepareMenuItemView(menuItemView: UIView!, date: NSDate!) {
        if (manager!.delegate != nil && manager!.delegate!.respondsToSelector("prepareMenuItemView"))
        {
            manager!.delegate!.calendar!(self.manager, prepareMenuItemView: menuItemView, date: date)
            return;
        }
        
        let text: String?
        
        if (date != nil) {
            let dateFormatter = manager!.dateHelper!.createDateFormatter()
            dateFormatter.timeZone = manager?.dateHelper.calendar().timeZone
            dateFormatter.locale = manager?.dateHelper.calendar().locale
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            
            text = "aaa"
        } else {
            text = nil
        }
        
        (menuItemView as! UILabel).text = text
    }
}*/

class ScheduleViewController: UIViewController, JTCalendarDelegate {
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
    @IBOutlet weak var horizCalendarView: JTHorizontalCalendarView!
    
    var calendarManager: JTCalendarManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarManager = JTCalendarManager()
        calendarManager.delegate = self
        
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = horizCalendarView
        calendarManager.setDate(NSDate())
        
        calendarMenuView.backgroundColor = ColorScheme.backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickMenuButton() {
        let appDelegate = UIApplication.sharedApplication().delegate
        appDelegate?.performSelector("toggleStatusBar")
    }
}