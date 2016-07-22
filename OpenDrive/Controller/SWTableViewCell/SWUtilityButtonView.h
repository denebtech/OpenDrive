//
//  SWUtilityButtonView.h
//  OpenDrive
//
//  Created by Bin Jin on 1/10/16.
//  Copyright © 2016 Bin Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTableViewCell;

#define kUtilityButtonWidthDefault 50

@interface SWUtilityButtonView : UIView

- (id)initWithUtilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector;
- (id)initWithFrame:(CGRect)frame utilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector;

@property (nonatomic, weak, readonly) SWTableViewCell *parentCell;
@property (nonatomic, copy) NSArray *utilityButtons;
@property (nonatomic, assign) SEL utilityButtonSelector;

- (void)setUtilityButtons:(NSArray *)utilityButtons WithButtonWidth:(CGFloat)width;
- (void)pushBackgroundColors;
- (void)popBackgroundColors;

@end
