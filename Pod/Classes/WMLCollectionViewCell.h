//
//  WMLCollectionViewCell.h
//  ControllerCollectionView
//
//  Created by Sash Zats on 10/4/14.
//  Copyright (c) 2014 Wondermall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMLCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly) UIView *containerView;
@property (nonatomic, strong, readonly) id contentViewController;

@end
