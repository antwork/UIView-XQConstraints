//
//  UIView+XQMyConstraints.m
//  AutolayoutRelationDemo
//
//  Created by Bill on 16/3/18.
//  Copyright © 2016年 Bill. All rights reserved.
//

#import "UIView+XQConstraints.h"

@implementation UIView (XQConstraints)

- (NSMutableArray *)xqConstraints {
    NSMutableArray *total = [NSMutableArray arrayWithArray:self.constraints];
    
    if (self.superview) {
        NSArray * constraints = [self.superview constraints];
        for (NSLayoutConstraint *tmp in constraints) {
            if (tmp.firstItem == self || tmp.secondItem == self) {
                [total addObject:tmp];
            }
        }
    }
    return total;
}

- (void)xqUpdateConstraint:(NSString *)identifier value:(CGFloat)constant {
    NSLayoutConstraint *constraint = [self xqFindConstraintByIdentifier:identifier];
    constraint.constant = constant;
}

- (void)xqRemoveConstraint:(NSString *)identifier {
    NSLayoutConstraint *constraint = [self xqFindConstraintByIdentifier:identifier];
    if (constraint) {
        if (constraint.firstItem && constraint.secondItem) {
            [self.superview removeConstraint:constraint];
        } else if (constraint.firstItem == self) {
            [self removeConstraint:constraint];
        }
    }
}

- (NSLayoutConstraint *)xqFindConstraintByIdentifier:(NSString *)identifier {
    if (!identifier) {
        return nil;
    }
    
    NSMutableArray *total = [self xqConstraints];
    for (NSLayoutConstraint *constraint in total) {
        if ([constraint.identifier isEqualToString:identifier]) {
            return constraint;
        }
    }
    
    return nil;
}

@end
