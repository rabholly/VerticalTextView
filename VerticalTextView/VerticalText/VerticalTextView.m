//
//  VerticalTextView.m
//  VerticalTextView
//
//  Created by horry on 15/8/18.
//  Copyright (c) 2015年 ___horryBear___. All rights reserved.
//

#import "VerticalTextView.h"
#import <CoreText/CoreText.h>

@implementation VerticalTextView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.aligment = VerticalTextAligmentRight;
	}
	return self;
}

- (void)setText:(NSString *)text {
	_text = text;
	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
	_font = font;
	[self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	if (!_text) {
		return;
	}
	
	_font = _font ? _font : [UIFont systemFontOfSize:17];
	_textColor = _textColor ? _textColor : [UIColor blackColor];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGFloat centerOffset = 0;
	CGFloat offset = 0;
	NSMutableAttributedString *attrStr = [self subStr:_text withLength:self.bounds.size.width];
	//计算居中的偏移
	CGRect strRect = [attrStr boundingRectWithSize:CGSizeMake(self.bounds.size.height, MAXFLOAT)
										options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
										context:nil];
	if (_aligment == VerticalTextAligmentCenter) {
		centerOffset = (self.bounds.size.width - strRect.size.height) / 2;
	} else {
		centerOffset = 0;
	}
	
	//添加中文
	BOOL totalChinese = true;
	for (int i = 0; i < attrStr.length; i++) {
		if ([self isChinese:attrStr.string index:i]) {
			[attrStr addAttributes:@{(id)kCTVerticalFormsAttributeName: @YES,
									 NSForegroundColorAttributeName: _textColor}
							 range:NSMakeRange(i, 1)];
		} else {
			totalChinese = false;
		}
	}
	
	if (!totalChinese) {
		offset = _font.pointSize / 3;
	}
	[self drawText:attrStr xOffset:offset - centerOffset  withContext:context];
	
	//添加非中文
	for (int i = 0; i < attrStr.length; i++) {
		if ([self isChinese:attrStr.string index:i]) {
			[attrStr addAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}
							 range:NSMakeRange(i, 1)];
		} else {
			[attrStr addAttributes:@{NSForegroundColorAttributeName: _textColor}
							 range:NSMakeRange(i, 1)];
		}
	}
	[self drawText:attrStr xOffset: - centerOffset  withContext:context];
}

- (BOOL)isChinese:(NSString *)s index:(int)index {
	NSString *subStr = [s substringWithRange:NSMakeRange(index, 1)];
	NSArray *array = @[@"【", @"】", @"—", @"♯", @"♭", @"（", @"）", @"…"];
	for (NSString *item in array) {
		if ([subStr isEqualToString:item]) {
			return NO;
		}
	}
	const char *cStr = [subStr UTF8String];
	return strlen(cStr) == 3;
}

- (void)drawText:(NSMutableAttributedString*)attrStr xOffset:(CGFloat)xOffset withContext:(CGContextRef)context{
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrStr);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, CGRectMake(self.bounds.origin.x + xOffset , self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height));
	CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
												CFRangeMake(0, 0),
												path,
												(CFDictionaryRef)@{(id)kCTFrameProgressionAttributeName: @(_aligment == VerticalTextAligmentLeft ? kCTFrameProgressionLeftToRight : kCTFrameProgressionRightToLeft)});
	CTFrameDraw(frame, context);
	CFRelease(framesetter);
	CFRelease(frame);
	CFRelease(path);
}

- (NSMutableAttributedString *)subStr:(NSString *)str withLength:(CGFloat)length {
	NSMutableAttributedString *attrStr = [NSMutableAttributedString alloc];
	for (int i = 1; i< [str length]; i++) {
		NSString *subStr = [str substringWithRange:NSMakeRange(0, i)];
		attrStr = [attrStr initWithString:subStr attributes:@{NSForegroundColorAttributeName: [UIColor clearColor], NSFontAttributeName: _font}];
		CGRect strRect = [attrStr boundingRectWithSize:CGSizeMake(self.bounds.size.height, MAXFLOAT)
											   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
											   context:nil];
		if (strRect.size.height > length) {
			subStr = [NSString stringWithFormat:@" %@…",[str substringWithRange:NSMakeRange(0, i - 3)]];
			return [attrStr initWithString:subStr attributes:@{NSForegroundColorAttributeName: [UIColor clearColor], NSFontAttributeName: _font}];
		}
	}
	return [attrStr initWithString:str attributes:@{NSForegroundColorAttributeName: [UIColor clearColor], NSFontAttributeName: _font}];
}

@end
