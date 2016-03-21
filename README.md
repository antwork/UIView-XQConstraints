<pre>
# UIView-XQConstraints
UIView Constraints extensions
// find all constraints relative to view
NSArray *allConstraints = [view xqConstraints];
// find certain constraint by identifier
NSLayoutConstraint *cons = [view xqFindConstraintByIdentifier:@"width"];
// update certain constraint by identifier and value
[view xqUpdateConstraint:@"width" value:50];
// setup chain block, change one constraint affect other 
[view xq_setChainBlock:^(UIView *tmpView, NSString *identifier, CGFloat value){
    if ([identifier isEqualToString:@"width"]) {
        NSLayoutConstraint *constraint = [tmpView xqFindConstraintByIdentifier:@"height"];
        constraint.constant = value;
    }
}];
</pre>
