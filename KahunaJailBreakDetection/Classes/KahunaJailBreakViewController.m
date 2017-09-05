//
//  KahunaJailBreakViewController.m
//  Pods
//
//  Created by Kahuna on 9/5/17.
//
//

#import "KahunaJailBreakViewController.h"
#import <UIKit/UIKit.h>

@interface KahunaJailBreakViewController ()

@property(strong,nonatomic) IBOutlet UILabel *appDesc;
@property(strong,nonatomic) IBOutlet UIView *appDescView;

@end

@implementation KahunaJailBreakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *appName = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleName"];
    if(appName.length > 0){
        self.appDesc.text = [NSString stringWithFormat:@"It appears that your device is compromised or rooted and %@ can not continue. Please contact our support team for further guidance.",appName];
    }
    [self.appDesc sizeToFit];
    [self.appDescView.layer setMasksToBounds:true];
    [self.appDescView.layer setCornerRadius:5.0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
