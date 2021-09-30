//
//  ViewController.m
//  alerts
//
//  Created by Mustafa Kılınç on 30.09.2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

bool isGrantedNotifications;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isGrantedNotifications = false;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        isGrantedNotifications = granted;
        
    }];
    
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)showAlert:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertActionStyleCancel];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Dissmiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *pushNotification = [UIAlertAction actionWithTitle:@"Create Local Notification" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //[alert dismissViewControllerAnimated:YES completion:nil];
        
        if(isGrantedNotifications){
            
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = @"This is a notification title";
            content.subtitle = @"This is a notification subtitle";
            content.body = @"This is a notification body";
            content.sound = [UNNotificationSound defaultSound];
            
            UNTimeIntervalNotificationTrigger *notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
            
            UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:content trigger:notificationTrigger];
            
            [center addNotificationRequest:notificationRequest withCompletionHandler:nil];
        }
        
        
        
    }];
   
    [alert addAction:cancel];
    [alert addAction:pushNotification];
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
