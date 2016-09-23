//
//  MainNavigationController.m
//  DigitalTechnology
//
//  Created by wmh on 16/8/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define ColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController
+ (void)initialize{
    [[UINavigationBar appearance] setBarTintColor:ColorWithRGB(29, 122, 251)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //[UINavigationBar appearanceWhenContainedInInstancesOfClasses:[UINavigationController.self].tintColor = UIColor.whiteColor];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]]setTintColor:[UIColor whiteColor]];
    
        //navigationBar.tintColor = [UIColor whiteColor];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
