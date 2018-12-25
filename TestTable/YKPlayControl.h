//
//  YKPlayControl.h
//  TestTable
//
//  Created by mc on 2018/12/24.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class VideoView;
@interface YKPlayControl : NSObject
@property (nonatomic,strong)NSMutableArray *playViews;//可以滑动view待播放的集合
@property (nonatomic,strong)NSMutableArray *playViewsUnScroll;//不可以滑动view待播放的集合
@property(nonatomic,weak)UIScrollView *scrollV;
+(instancetype)sharePlayControl;
-(void)autoPlayWith:(VideoView*)videoV;
@end

NS_ASSUME_NONNULL_END
