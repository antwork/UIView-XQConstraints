//
//  UIView+XQMyConstraints.h
//  AutolayoutRelationDemo
//
//  Created by Bill on 16/3/18.
//  Copyright © 2016年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XQConstraints)

- (NSMutableArray *)xqConstraints;

- (void)xqUpdateConstraint:(NSString *)identifier value:(CGFloat)constant;

- (void)xqRemoveConstraint:(NSString *)identifier;

- (NSLayoutConstraint *)xqFindConstraintByIdentifier:(NSString *)identifier;

@end
