//
//  ViewController.m
//  ZYLocationManager
//
//  Created by lzy on 16/7/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ViewController.h"
#import "ZYLocationManager.h"

@interface ViewController () <UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryLocation];
}

- (void)queryLocation {
    __weak __typeof(self) weakSelf = self;
    [[ZYLocationManager shareManager] getLocationCoordinate:weakSelf complete:^(CLLocationCoordinate2D location, NSError *error) {
        if (nil == error) {
            //do something
            NSLog(@"\n\nlocation - \nlo:%f    la:%f\n", location.latitude, location.longitude);
        } else {
            //verify authority
            authorityBlock(error, weakSelf);
        }
    }];
    
    [[ZYLocationManager shareManager] getCity:weakSelf complete:^(NSString *city, CLLocationCoordinate2D location, NSError *error) {
        if (nil == error) {
            //do something
            NSLog(@"\n\ncity : %@  \nlocation - \nlo:%f    la:%f\n", city, location.latitude, location.longitude);
        } else {
            //verify authority
            authorityBlock(error, weakSelf);
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else if (buttonIndex == alertView.cancelButtonIndex) {
        //tips
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
