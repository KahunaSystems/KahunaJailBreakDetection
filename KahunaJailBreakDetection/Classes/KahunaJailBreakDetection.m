//
//  KahunaJailBreakDetection.m
//  KahunaJailBreakDetection
//
//  Created by Siddharth on 7/210/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

#import "KahunaJailBreakDetection.h"
#import "KahunaJailBreakViewController.h"

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

- (UIViewController *)getYourViewController{
    return self.jailBreakViewController;
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
        KahunaJailBreakViewController *viewController = [[KahunaJailBreakViewController alloc]initWithNibName:@"KahunaJailBreakViewController" bundle:nil];
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            viewController = [[KahunaJailBreakViewController alloc]initWithNibName:@"KahunaJailBreakViewController_iPad" bundle:nil];
        }
        if(viewController!=nil){
            [self.jailBreakViewController presentViewController:viewController animated:true completion:nil];
        }
    }
}

@end
