//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Eric Mead on 10/3/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"


@interface BNRDrawViewController ()

@property (nonatomic, strong) NSNotificationCenter *center;

@property (weak, nonatomic) IBOutlet UIButton *buttonOutlet;


@end

@implementation BNRDrawViewController

- (IBAction)buttonTapped:(id)sender {
    
    
}


- (void)loadView {
 
    
    self.view = [[BNRDrawView alloc]initWithFrame:CGRectZero];
    
    //[self setUpdismissButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view bringSubviewToFront:self.buttonOutlet];

    
}

- (void) dismiss {
    
     NSLog(@"got to dismiss function at least");
    
    
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

- (IBAction)button:(id)sender {
}
@end
