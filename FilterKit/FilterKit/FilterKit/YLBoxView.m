//
//  YLBoxView.m
//  FilterKit
//
//  Created by Raindew on 2017/3/22.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "YLBoxView.h"
#import "FilterHeader.h"
@interface YLBoxView ()
@property(nonatomic, strong) NSArray *titles;


@end



@implementation YLBoxView


- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        
        //底部线条
        CALayer *bottomLayer = [CALayer layer];
        bottomLayer.borderWidth = 0.5;
        bottomLayer.borderColor = LineColor.CGColor;
        bottomLayer.frame = CGRectMake(0, frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
        [self.layer addSublayer:bottomLayer];
        
        self.titles = titles;

        [self setupUI];
    }

    return self;
}

- (void)setupUI {

    
    for (int i = 0; i < self.titles.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*CGRectGetWidth(self.frame) / self.titles.count, 0, CGRectGetWidth(self.frame) / self.titles.count, CGRectGetHeight(self.frame));
        button.tag = i + 1;
        button.selected = NO;
        button.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
        button.titleLabel.font = Font(13.);
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:NormalColor forState:UIControlStateNormal];
        [button setTitleColor:SelectedColor forState:UIControlStateSelected];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
        //右侧标记状态的图片
        UIImageView *statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(button.frame) - 15, 0, 10, CGRectGetHeight(button.frame))];
        statusImage.image = [UIImage imageNamed:@"pulldown"];
        statusImage.contentMode = UIViewContentModeScaleAspectFit;
        statusImage.tag = button.tag + 100;
        [button addSubview:statusImage];
        [button addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //给按钮中间画一条竖线
        if (i < self.titles.count) {
            UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
            UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
            NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
            NSArray *locations = @[@0.2, @0.5, @0.8];
            CAGradientLayer *lineLayer = [CAGradientLayer layer];
            lineLayer.colors = colors;
            lineLayer.locations = locations;
            lineLayer.startPoint = CGPointMake(0, 0);
            lineLayer.endPoint = CGPointMake(0, 1);
            lineLayer.frame = CGRectMake(CGRectGetMaxX(button.frame), 0, 1.0, CGRectGetHeight(self.frame));
            [self.layer addSublayer:lineLayer];
        }
        
    }

}

#pragma mark -- 点击了boxView上的按钮

- (void)didSelectedButton:(UIButton *)sender {
    
   
    //修改按钮状态
    if (sender.selected) {//如果按钮已经被点击了   取消选中  调用dismiss
        [sender setSelected:NO];
        for (int i = 0; i < self.titles.count; i++) {//更改对应图片状态
            UIImageView *imageView = [sender viewWithTag:sender.tag +  100];
            imageView.image = [UIImage imageNamed:@"pulldown"];
        }
    }else {//如果没有被点击  先把所有按钮调整为非选中状态  再把点击的按钮、图片调整为选中  最后调用代理
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *btn = (UIButton *)[[sender superview]viewWithTag:i + 1];
            [btn setSelected:NO];
            for (int i = 0; i < self.titles.count; i++) {
                UIImageView *imageView = [btn viewWithTag:btn.tag +  100];
                imageView.image = [UIImage imageNamed:@"pulldown"];
            }
        }
        [sender setSelected:YES];
        for (int i = 0; i < self.titles.count; i++) {
            UIImageView *imageView = [sender viewWithTag:sender.tag +  100];
            imageView.image = [UIImage imageNamed:@"pullup"];
        }
        
        if ([self.delegate respondsToSelector:@selector(didSelectedBoxView:atIndex:)]) {
            [self.delegate didSelectedBoxView:self atIndex:sender.tag];
        }
    }
}

#pragma mark -- 视图消失

- (void)dismiss {

    //所有按钮设为非选择
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *btn = [self viewWithTag:i + 1];
        [btn setSelected:NO];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismiss];

}

@end
