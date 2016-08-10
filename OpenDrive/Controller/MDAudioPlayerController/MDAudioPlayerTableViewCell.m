//
//  MDAudioPlayerTableViewCell.m
//  OpenDrive
//
//  Created by ioshero on 2/22/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

#import "MDAudioPlayerTableViewCell.h"
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MDTableViewCellView : UIView
@end

@implementation MDTableViewCellView

- (void)drawRect:(CGRect)r
{
    if (IS_OS_8_OR_LATER) {
        [(MDAudioPlayerTableViewCell *)[self superview] drawContentView:r];
    }
    else if (IS_OS_7_OR_LATER) {
        [(MDAudioPlayerTableViewCell *)[self superview].superview drawContentView:r];
    }
    else {
        [(MDAudioPlayerTableViewCell *)[self superview] drawContentView:r];
    }
}

@end


@implementation MDAudioPlayerTableViewCell

@synthesize title;
@synthesize number;
@synthesize duration;
@synthesize isEven;
@synthesize isSelectedIndex;

static UIFont *textFont = nil;

+ (void)initialize
{
	if (self == [MDAudioPlayerTableViewCell class])
	{
		textFont = [UIFont boldSystemFontOfSize:15];
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
	{
		contentView = [[MDTableViewCellView alloc] initWithFrame:CGRectZero];
		contentView.opaque = NO;
		[self addSubview:contentView];
	}
	
	return self;
}

- (void)setTitle:(NSString *)s
{
    title = [s stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[self setNeedsDisplay]; 
}

- (void)setNumber:(NSString *)s
{
    number = s;
	[self setNeedsDisplay]; 
}

- (void)setDuration:(NSString *)s
{
    duration = s;
	[self setNeedsDisplay]; 
}

- (void)setIsSelectedIndex:(BOOL)flag
{
	isSelectedIndex = flag;
	[self setNeedsDisplay];
}

- (void)setFrame:(CGRect)f
{
	[super setFrame:f];
	[contentView setFrame:[self bounds]];
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)r
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *bgColor;
	
	if (self.highlighted)
		bgColor = [UIColor blackColor];
	else
		bgColor = self.isEven ? [UIColor colorWithWhite:0.0 alpha:0.95] : [UIColor blackColor];
	
	UIColor *textColor = [UIColor whiteColor];
	UIColor *dividerColor = self.highlighted ? [UIColor clearColor] : [UIColor colorWithRed:0.986 green:0.933 blue:0.994 alpha:0.13];
	
	[bgColor set];
	CGContextFillRect(context, r);
	
	[textColor set];
	
	[title drawInRect:CGRectMake(75, 12, 180, 15) withFont:textFont lineBreakMode:NSLineBreakByTruncatingTail];
	[number drawInRect:CGRectMake(5, 12, 35, 15) withFont:textFont lineBreakMode:NSLineBreakByTruncatingTail];
	[duration drawInRect:CGRectMake(255, 12, 55, 15) withFont:textFont lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentRight];
	
	[dividerColor set];
	
	CGContextSetLineWidth(context, 0.5);
	
	CGContextMoveToPoint(context, 63.5, 0.0);
	CGContextAddLineToPoint(context, 63.5, r.size.height);
	
	CGContextMoveToPoint(context, 260.5, 0.0);
	CGContextAddLineToPoint(context, 260.5, r.size.height);
	
	CGContextStrokePath(context);
	
	if (self.isSelectedIndex)
	{		
		[self.highlighted ? [UIColor whiteColor] : [UIColor colorWithRed:0.090 green:0.274 blue:0.873 alpha:1.000] set];
		
		CGContextMoveToPoint(context, 45, 17);
		CGContextAddLineToPoint(context, 45, 27);
		CGContextAddLineToPoint(context, 55, 22);
		
		CGContextClosePath(context);
		
		CGContextFillPath(context);
	}
}

@end
