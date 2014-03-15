//
//  TableViewController.m
//  VIEventTracker
//
//  Created by Vito on 3/15/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#import "TableViewController.h"
#import "VIEventTracker.h"

#define kShowOnce @"kShowOnce"
#define kShowAt3rdClick @"kShowAt3rdClick"

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showOnceDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *showAt3rdClickDetailLabel;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [VIEventTracker trackOnceEvent:kShowOnce
                                   handler:^(NSUInteger count) {
                                       [self showAlertViewWithContent:@"Event: ShowOnce\nOnly show one time."];
                                       self.showOnceDetailLabel.text = @"Shown";
                                       self.showOnceDetailLabel.textColor = [UIColor purpleColor];
                                   }];

        } else {
            [VIEventTracker trackEvent:kShowAt3rdClick
                               handler:^(NSUInteger count) {
                                   self.showAt3rdClickDetailLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
                                   if (count == 3) {
                                       [self showAlertViewWithContent:@"Event: ShowAt3Click\nOnly show at 3rd click."];
                                       self.showAt3rdClickDetailLabel.text = @"Shown";
                                       self.showAt3rdClickDetailLabel.textColor = [UIColor purpleColor];
                                   }
                               }];
        }
    } else {
        if (indexPath.row == 0) {
            [VIEventTracker stopTrackEvent:kShowOnce];
            self.showOnceDetailLabel.text = @"Stoped";
            self.showOnceDetailLabel.textColor = [UIColor redColor];
            
            [VIEventTracker stopTrackEvent:kShowAt3rdClick];
            self.showAt3rdClickDetailLabel.text = @"Stoped";
            self.showAt3rdClickDetailLabel.textColor = [UIColor redColor];

        } else {
            [VIEventTracker resetEvent:kShowOnce];
            self.showOnceDetailLabel.text = @"0";
            self.showOnceDetailLabel.textColor = [UIColor grayColor];
            
            [VIEventTracker resetEvent:kShowAt3rdClick];
            self.showAt3rdClickDetailLabel.text = @"0";
            self.showAt3rdClickDetailLabel.textColor = [UIColor grayColor];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showAlertViewWithContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Show Alert View"
                                                        message:content
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
