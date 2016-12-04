//
//  WMLCollectionView.m
//  ControllerCollectionView
//
//  Created by Sash Zats on 10/4/14.
//  Copyright (c) 2014 Wondermall. All rights reserved.
//

#import "WMLCollectionView.h"

#import "WMLCollectionViewCell.h"
#import "WMLCollectionViewCell+Internal.h"
#import "WMLCollectionViewCellDelegate.h"

@interface WMLCollectionView () <WMLCollectionViewCellDelegate>

@end

@implementation WMLCollectionView

- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                forIndexPath:(NSIndexPath *)indexPath {
    WMLCollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier
                                               forIndexPath:indexPath];
    if (![cell isKindOfClass:[WMLCollectionViewCell class]]) {
        return cell;
    }
    cell.delegate = self;
    UIViewController *controller = [self.dataSource collectionView:self controllerForIndexPath:indexPath];
    NSAssert(controller && [controller isKindOfClass:[UIViewController class]], @"The collection view's data source did not return a valid view controller for identifier %@", identifier);
    cell.contentViewController = controller;
    
    return cell;
}

#pragma mark - Public

- (void)didEndDisplayingCell:(WMLCollectionViewCell *)cell {
    if (![cell isKindOfClass:[WMLCollectionViewCell class]]) {
        return;
    }
    UIViewController *controller = cell.contentViewController;
}

- (void)willDisplayCell:(WMLCollectionViewCell *)cell {
}

#pragma mark - Private

- (void)_unhostViewController:(UIViewController *)controller {
    if(controller.view.superview) {
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
}

- (void)_hostViewController:(UIViewController *)controller withHostView:(UIView *)superview {
    if(![superview.subviews containsObject:controller.view]) {
        [self.containerViewController addChildViewController:controller];
        controller.view.frame = superview.bounds;
        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [superview addSubview:controller.view];
        [controller didMoveToParentViewController:self.containerViewController];
    }
}

#pragma mark - WMLCollectionViewCellDelegate

- (void)collectionViewCell:(WMLCollectionViewCell *)cell willMoveToWindow:(UIWindow *)window {
    [self _hostViewController:cell.contentViewController withHostView:cell.containerView];
}

- (void)collectionViewCellWillPrepareForReuse:(WMLCollectionViewCell *)cell {
    [self _hostViewController:cell.contentViewController withHostView:cell.containerView];
}

@end
