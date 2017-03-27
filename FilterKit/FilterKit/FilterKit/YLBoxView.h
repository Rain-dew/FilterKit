//
//  YLBoxView.h
//  FilterKit
//
//  Created by Raindew on 2017/3/22.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum _FilterType {
    FilterSingeType  = 0,
    FilterDoubleType,
    FilterThireeType
} FilterType;
@class YLBoxView;
@protocol  YLBoxViewDelegate <NSObject>
- (void)didSelectedBoxView:(YLBoxView *)boxView atIndex:(NSInteger)index;
@end
@interface YLBoxView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;
@property(nonatomic, weak) id<YLBoxViewDelegate> delegate;

@property(nonatomic, strong) NSArray *types;//几列

@property(nonatomic, strong) NSArray *dataSource;//数据源

@end
