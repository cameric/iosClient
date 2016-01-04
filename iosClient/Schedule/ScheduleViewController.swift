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
    
    let calendarManager = JTCalendarManager()
    
    var dateSelected: NSDate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: JTCalendarManager delegate
    
    /**
        Called when a day view is tapped.
    
        - parameter calendar The calendar manager concerning the day view.
        - parameter view The day view that was tapped.
    */
    func calendar(calendar: JTCalendarManager!, didTouchDayView view: UIView!) {
        guard let dayView = view as? JTCalendarDayView else {
            // Wrong view. Error?
            return
        }
        
        dateSelected = dayView.date
        
        // If we click on a date from another month, switch to that month
        let contentView = (calendar.contentView as! JTContent)
        if (!calendarManager.dateHelper.date(contentView.date(), isTheSameMonthThan: dayView.date)) {
            if (contentView.date().compare(dayView.date) == NSComparisonResult.OrderedAscending) {
                contentView.loadNextPageWithAnimation()
            } else {
                contentView.loadPreviousPageWithAnimation()
            }
        }
        
        calendar.reload()
    }
    
    /**
     Called when a day view is to be rendered.
     
     - parameter calendar The calendar manager concerning the day view.
     - parameter view The day view that is being rendered.
     */
    func calendar(calendar: JTCalendarManager!, prepareDayView view: UIView!) {
        guard let dayView = view as? JTCalendarDayView else {
            // Wrong view. Error?
            return
        }
        
        // Things can be made less circular like so...
        // dayView.circleView.layer.cornerRadius = 0
        
        // Day is from another month
        if (dayView.isFromAnotherMonth) {
            dayView.circleView.hidden = true
            dayView.circleView.backgroundColor = UIColor.blueColor()
            dayView.textLabel.textColor = UIColor.grayColor()
        }
        // Day is today
        else if (calendarManager.dateHelper.date(NSDate(), isTheSameDayThan: dayView.date)) {
            dayView.circleView.hidden = false
            dayView.circleView.backgroundColor = UIColor.blueColor()
            dayView.dotView.backgroundColor = UIColor.whiteColor()
            dayView.textLabel.textColor = UIColor.whiteColor()
        }
        // Day is selected
        else if (dateSelected != nil && calendarManager.dateHelper.date(dateSelected, isTheSameDayThan: dayView.date)) {
            dayView.circleView.hidden = false
            dayView.circleView.backgroundColor = UIColor.redColor()
            dayView.dotView.backgroundColor = UIColor.whiteColor()
            dayView.textLabel.textColor = UIColor.whiteColor()
        }
        // Day is another day of the current month
        else {
            dayView.circleView.hidden = true
            dayView.circleView.backgroundColor = UIColor.blueColor()
            dayView.textLabel.textColor = UIColor.blackColor()
        }
    }
}