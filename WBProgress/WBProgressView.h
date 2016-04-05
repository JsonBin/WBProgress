//
//  WBProgressView.h
//  WBProgress
//
//  Created by Zwb on 16/4/5.
//  Copyright © 2016年 zwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBProgressView : UIView

/**
 *  圆形指示器
 *
 *  @param frame       frame
 *  @param progress    进度 (0~1之间)
 *  @param linewidth   圆弧的宽度
 *  @param topColor    上半部分颜色
 *  @param bottomColor 下半部分颜色
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress lineWidth:(CGFloat)linewidth topColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

/**
 *  添加指示器到视图中
 *
 *  @param view 需要添加的视图
 */
- (void) showProgressViewInView:(UIView *)view;

@end
