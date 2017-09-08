//
//  KahunaJailBreakDetection.m
//  KahunaJailBreakDetection
//
//  Created by Siddharth on 7/210/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

#import "KahunaJailBreakDetection.h"
//#import "KahunaJailBreakViewController.h"

@interface KahunaJailBreakDetection ()

@property(strong,nonatomic) UIViewController *jailBreakViewController;

@end

@implementation KahunaJailBreakDetection

+(id)sharedInstance {
    static KahunaJailBreakDetection *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[KahunaJailBreakDetection alloc]init];
    });
    return __sharedInstance;
}

-(void)setYourViewController:(UIViewController *)viewController{
    self.jailBreakViewController = viewController;
}

+ (BOOL)isJailbroken
{
#if !(TARGET_IPHONE_SIMULATOR)

    FILE *file = fopen("/Applications/Cydia.app", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/bin/bash", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/usr/sbin/sshd", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/etc/apt", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    file = fopen("/usr/bin/ssh", "r");
    if (file) {
        fclose(file);
        return YES;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/sbin/sshd"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/etc/apt"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/usr/bin/ssh"]) {
        return YES;
    }
    
    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        return YES;
    } else {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        return YES;
    }
#endif
    return NO;
}

-(void)checkJailDeviceinDevice{
    if ([KahunaJailBreakDetection isJailbroken]) {
        NSString *appName = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleName"];
        NSString *appDesc = @"";
        if(appName.length > 0){
            appDesc = [NSString stringWithFormat:@"It appears that your device is compromised or rooted and %@ can not continue. Please contact our support team for further guidance.",appName];
        }
        NSDictionary *attrDict = @{
                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:21.0],
                                   NSForegroundColorAttributeName : [UIColor redColor]
                                   };
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Security Error" attributes:attrDict];
        NSDictionary *attrDict1 = @{
                                    NSForegroundColorAttributeName : [UIColor blackColor]
                                    };
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:appDesc attributes:attrDict1];
        
        NSRange boldRange = [appDesc rangeOfString:appName];
        [attributedString1 addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:boldRange];
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@""
                                                                               message:@""
                                                                        preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:attributedString forKey:@"attributedTitle"];
        [alertController setValue:attributedString1 forKey:@"attributedMessage"];
        if(self.jailBreakViewController!=nil){
            [self.jailBreakViewController presentViewController:alertController animated:true completion:nil];
        }
    }
}

@end
