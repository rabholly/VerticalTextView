//
//  ViewController.m
//  VerticalTextView
//
//  Created by horry on 15/8/18.
//  Copyright (c) 2015年 ___horryBear___. All rights reserved.
//

#import "ViewController.h"
#import "VerticalTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	VerticalTextView *leftText = [[VerticalTextView alloc] initWithFrame:CGRectMake(10, 40, 50, 400)];
//	leftText.aligment = VerticalTextAligmentLeft;
//	leftText.text = @"今天有个meetting，主题是【总结】，请准时到场";
//	leftText.backgroundColor = [UIColor greenColor];
//	[self.view addSubview:leftText];
//	
//	VerticalTextView *centerText = [[VerticalTextView alloc] initWithFrame:CGRectMake(70, 40, 120, 400)];
//	centerText.aligment = VerticalTextAligmentCenter;
//	centerText.text = @"人生就是一列开往坟墓的列车，路途上会有很多站，很难有人可以自始至终陪着走完。当陪你的人要下车时，即使不舍也该心存感激，然后挥手道别。";
//	centerText.backgroundColor = [UIColor greenColor];
//	[self.view addSubview:centerText];
//	
	VerticalTextView *rightText = [[VerticalTextView alloc] initWithFrame:CGRectMake(200, 40, 100, 200)];
	rightText.aligment = VerticalTextAligmentRight;
	rightText.text = @"我曾听人说过，当你不能够再拥有，你唯一可以做的，就是令自己不要忘记。";
	rightText.backgroundColor = [UIColor clearColor];
	[self.view addSubview:rightText];
	
//	UILabel *verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 21, 200)];
//	verticalLabel.numberOfLines = 0;
//	verticalLabel.lineBreakMode = NSLineBreakByWordWrapping;
//	verticalLabel.text = @"竖排文字";
//	[self.view addSubview:verticalLabel];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
