//
//  KahunaJailBreakDetection.h
//  KahunaJailBreakDetection
//
//  Created by Siddharth on 7/210/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KahunaJailBreakDetection : NSObject

+ (BOOL)isJailbroken;
+ (id)sharedInstance;
- (void)setYourViewController:(UIViewController *)viewController;
- (void)checkJailDeviceinDevice;

@end
