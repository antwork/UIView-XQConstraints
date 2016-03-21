//
//  ViewController.m
//  XQConstraintDemo
//
//  Created by Bill on 16/3/18.
//  Copyright © 2016年 Bill. All rights reserved.
//

#import "ViewController.h"
#import "UIView+XQConstraints.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
    self.testView = view;
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:50];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    widthConstraint.identifier = @"width";
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    heightConstraint.identifier = @"height";
    
    NSArray *constraints = @[leadingConstraint, topConstraint, widthConstraint, heightConstraint];
    [self.view addConstraints:constraints];
    
    // find all constraints relative to view
    NSArray *allConstraints = [view xqConstraints];
    NSLog(@"all constraints:%@", allConstraints);
    
    // find certain constraint by identifier
    NSLayoutConstraint *cons = [view xqFindConstraintByIdentifier:@"width"];
    NSLog(@"width constraint:%@", cons);
    
    // update certain constraint by identifier and value
    [view xqUpdateConstraint:@"width" value:50];
    
    // setup chain block, change one constraint affect other
    // use [xx xqUpdateConstraint:@"" value:aa] to update constraint constant
    [view xq_setChainBlock:^(UIView *tmpView, NSString *identifier, CGFloat value){
        if ([identifier isEqualToString:@"width"]) {
            NSLayoutConstraint *constraint = [tmpView xqFindConstraintByIdentifier:@"height"];
            constraint.constant = value;
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)submitBtnPressed:(id)sender {
    CGFloat value = [[self.valueField text] floatValue];
    if (value <= 30) {
        value = 30;
    }
    // update certain constraint by identifier and value
    [self.testView xqUpdateConstraint:@"width" value:value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
