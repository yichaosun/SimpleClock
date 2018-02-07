//
//  Timer2ViewController.swift
//  SimpleClock
//
//  Created by 曾天宇 on 26/01/2018.
//  Copyright © 2018 曾天宇. All rights reserved.
//
import AVFoundation
import Cocoa

class Timer2ViewController : NSViewController, NSUserNotificationCenterDelegate{
    @IBOutlet weak var StartButton: NSButton!
    @IBOutlet weak var PauseButton: NSButton!
    @IBOutlet weak var EndButton: NSButton!
    
    @IBOutlet weak var TimerText: NSTextField!
    
    @IBOutlet weak var HourText: NSTextField!
    @IBOutlet weak var MinuteText: NSTextField!
    @IBOutlet weak var SecondText: NSTextField!
    
    var isStart = Bool(false)
    var isPause = Bool(false)
    
    @IBOutlet weak var Indicater: NSProgressIndicator!
    var timer : Timer!
    
    var hour = Int(0)
    var minute = Int(0)
    var second = Int(0)
    
    var totalSecond = Int(0)
    var total = Int(0)
    var runningSec = Int(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timerMain()
        })
        timer.fireDate = Date.distantFuture
    }
    
    func timerMain() -> Void {
        if TimerText.stringValue == "00:00:00" {
            timer.fireDate = Date.distantFuture
            TimerText.textColor = NSColor.red
            NSSound(named: NSSound.Name(rawValue: "Glass.aiff"))?.play()
            let userNotification = NSUserNotification()
            userNotification.title = "Time Up! "
            userNotification.subtitle = String(format: "The Timer is ended. Total seconds: %ds", total)
            userNotification.informativeText = String(format: "SimpleClock Timer is ended. Total seconds: %ds; Running seconds: %ds.", total, runningSec - 1)
            let userNotificationCenter = NSUserNotificationCenter.default
            userNotificationCenter.scheduleNotification(userNotification)
        }else{
            Indicater.doubleValue = Double(totalSecond)
            hour = totalSecond / 3600
            minute = totalSecond % 3600 / 60
            second = totalSecond % 3600 % 60
            TimerText.stringValue = String(format: "%02d:%02d:%02d", hour, minute, second)
            totalSecond -= 1
            runningSec += 1
            if hour == 0 && minute == 0 && second == 0{
                timer.fireDate = Date.distantFuture
                TimerText.textColor = NSColor.red
                NSSound(named: NSSound.Name(rawValue: "Glass.aiff"))?.play()
                let userNotification = NSUserNotification()
                userNotification.title = "Time Up! "
                userNotification.subtitle = String(format: "The Timer is ended. Total seconds: %ds", total)
                userNotification.informativeText = String(format: "SimpleClock Timer is ended. Total seconds: %ds; Running seconds: %ds.", total, runningSec - 1)
                let userNotificationCenter = NSUserNotificationCenter.default
                userNotificationCenter.scheduleNotification(userNotification)
            }
        }

    }

    
    @IBAction func StartTimer(_ sender: NSButton) {
        if isStart==false{
            isStart = true
            if HourText.stringValue == ""{
                HourText.stringValue = "0"
            }
            if MinuteText.stringValue == ""{
                MinuteText.stringValue = "0"
                
            }
            if SecondText.stringValue == ""{
                SecondText.stringValue = "0"
            }
            totalSecond = Int(self.HourText.stringValue)!*3600 + Int(self.MinuteText.stringValue)!*60 + Int(self.SecondText.stringValue)!
            total = totalSecond
            hour = totalSecond / 3600
            minute = totalSecond % 3600 / 60
            second = totalSecond % 3600 % 60
            TimerText.stringValue = String(format: "%02d:%02d:%02d", hour, minute, second)
            //计时器启动
            let userNotification = NSUserNotification()
            userNotification.title = "Timer Start"
            let userNotificationCenter = NSUserNotificationCenter.default
            userNotificationCenter.scheduleNotification(userNotification)
            Indicater.doubleValue = Double(totalSecond)
            Indicater.maxValue = Double(totalSecond)
            timer.fireDate = NSDate.init() as Date
            TimerText.textColor = NSColor.white
            NSSound(named: NSSound.Name(rawValue: "Glass.aiff"))?.play()
            runningSec = 0
        }else if isPause{
            timer.fireDate = NSDate.init() as Date
            isPause = false
            NSSound(named: NSSound.Name(rawValue: "Pop.aiff"))?.play()
        }
    }
    
    @IBAction func PauseTimer(_ sender: NSButton) {
        if isStart {
            isPause = true
            timer.fireDate = Date.distantFuture
            NSSound(named: NSSound.Name(rawValue: "Pop.aiff"))?.play()
        }
    }
    
    
    @IBAction func EndTimer(_ sender: NSButton) {
        if isStart {
            isStart = false
            timer.fireDate = Date.distantFuture
            hour = 0
            minute = 0
            second = 0
            TimerText.stringValue = "00:00:00"
            Indicater.doubleValue = 0
            TimerText.textColor = NSColor.white
            NSSound(named: NSSound.Name(rawValue: "Glass.aiff"))?.play()
            
            let userNotification = NSUserNotification()
            userNotification.title = "Time Up! "
            userNotification.subtitle = String(format: "The Timer is ended. Total seconds: %ds", total)
            userNotification.informativeText = String(format: "SimpleClock Timer is ended manually. Running seconds: %ds.", runningSec - 1)
            let userNotificationCenter = NSUserNotificationCenter.default
            userNotificationCenter.scheduleNotification(userNotification)
            totalSecond = 0
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}
