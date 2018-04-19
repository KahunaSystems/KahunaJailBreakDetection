//
//  KahunaJailBreakDetection.swift
//  KahunaJailBreakDetection
//
//  Created by Siddharth Chopra on 21/02/18.
//

import Foundation
import UIKit

public class KahunaJailBreakDetection: NSObject {

    public static let sharedInstance = KahunaJailBreakDetection()
    var jailBreakViewController: UIViewController?

    public override init() {
        super.init()
    }

    public func setYourViewController(_ viewController: UIViewController) {
        self.jailBreakViewController = viewController
    }

    public class func isJailbroken() -> Bool {
        if TARGET_IPHONE_SIMULATOR != 1 {
            // Check existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || FileManager.default.fileExists(atPath: "/usr/bin/ssh") {
                return true
            }
            // Check if the app can open a Cydia's URL scheme
            if let aString = URL(string: "cydia://package/com.example.package") {
                if UIApplication.shared.canOpenURL(aString) {
                    return true
                }
            }
            // Check if the app can access outside of its sandbox
            let stringToWrite = "Jailbreak Test"
            do {
                try stringToWrite.write(toFile: "/private/jailbreak.txt", atomically: true, encoding: .utf8)
                //Device is jailbroken
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }

    public func checkJailDeviceinDevice() {
        if KahunaJailBreakDetection.isJailbroken() {
            var appDesc = ""
            var appName = ""
            if let appname = Bundle.main.infoDictionary?["CFBundleName"] as? String, appname.count > 0 {
                appDesc = "It appears that your device is compromised or rooted and \(appname) can not continue. Please contact our support team for further guidance."
                appName = appname
            }
            let attrDict = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 21.0), NSForegroundColorAttributeName: UIColor.red]
            let attributedString = NSMutableAttributedString(string: "Security Error", attributes: attrDict)
            let attrDict1 = [NSForegroundColorAttributeName: UIColor.black]
            let attributedString1 = NSMutableAttributedString(string: appDesc, attributes: attrDict1)
            let boldRange: NSRange? = (appDesc as NSString).range(of: appName)
            if let aRange = boldRange {
                attributedString1.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 17), range: aRange)
            }
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertController.setValue(attributedString, forKey: "attributedTitle")
            alertController.setValue(attributedString1, forKey: "attributedMessage")
            if self.jailBreakViewController != nil {
                self.jailBreakViewController?.present(alertController, animated: true) { () -> Void in }
            }
        }
    }

}

