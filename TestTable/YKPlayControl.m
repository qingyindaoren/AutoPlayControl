//
//  YKPlayControl.m
//  TestTable
//
//  Created by mc on 2018/12/24.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "YKPlayControl.h"
#import "VideoView.h"
@interface YKPlayControl()
@property(nonatomic,assign) BOOL isUpGes;




@end
@implementation YKPlayControl
+(instancetype)sharePlayControl{
    static YKPlayControl *control;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    control = [YKPlayControl new];
    control.playViews = [NSMutableArray array];
    control.playViewsUnScroll = [NSMutableArray array];
});
    return control;
}
-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];

}

-(void)setScrollV:(UIScrollView *)scrollV{
    if (_scrollV == scrollV) {
        
    }else{
    _scrollV = scrollV;
       
          [self.scrollV addObserver:self forKeyPath:@"contentOffset" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        // 放开延迟 即可见的视频都播放
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self visiblePlay]; //只播放一个可见
//        });
        
//       VideoView *videoV = (VideoView*)self.playViews.firstObject ;//只播放一个视频
//                CGRect rect=   [videoV convertRect:videoV.frame toView:self.scrollV];
//                CGRect screenRect = self.scrollV.bounds;
//                CGRect intersectionRect = CGRectIntersection(rect, screenRect);
//                if(CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)){
//                    return;
//
//                }else{
//                    if (intersectionRect.size.height>videoV.frame.size.height/2 && intersectionRect.size.width>videoV.frame.size.width/2) {
//                         [videoV play];
//                    }
//
////                    NSLog(@"交叉%@",NSStringFromCGRect(intersectionRect) );
//                }
        
    }
}
/** 添加观察者必须要实现的方法 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    /** 打印新老值 */
    // 从打印结果看 分别打印出了 name 与 height的新老值
    //    NSLog(@"old : %@  new : %@",[change objectForKey:@"old"],[change objectForKey:@"new"]);
//            NSLog(@"keypath :  %@",keyPath);
//            NSLog(@"change : %@",change);
    CGPoint old = [[change objectForKey:@"old"]CGPointValue];
    CGPoint new = [[change objectForKey:@"new"]CGPointValue];
 
    
    if (CGPointEqualToPoint(old, new)) {
        
        return;
    }else{
        if (new.y>old.y) {
            self.isUpGes = YES;
            
            
        }else{//向下滑
            self.isUpGes = NO;
            
        }
        
        [self visiblePlay];
        
    }
 
}
//父视图以及父、父等不能滑动
-(void)autoPlayWith:(VideoView*)videoV{
    if (!videoV.isPlaying) {//只播放一个可见视频
        for (VideoView* v in self.playViewsUnScroll) {
            if (v.isPlaying ) {
                return;
            }
        }
        [videoV play];
        return;
    }else{
        return;
    }
//     if (!videoV.isPlaying) {//可见都播放
//         [videoV play];
//     }
}
-(void)visiblePlay{
    for (VideoView* videoV in self.playViews) {
        CGRect rect=   [videoV convertRect:videoV.frame toView:self.scrollV];
        CGRect screenRect = self.scrollV.bounds;
        CGRect intersectionRect = CGRectIntersection(rect, screenRect);
        if(CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)){
            if (videoV.isPlaying) {
                [videoV stop];
            }
            
        }else{
            //                        NSLog(@"交叉%@",NSStringFromCGRect(intersectionRect) );
            if (intersectionRect.size.height>videoV.frame.size.height/2 && intersectionRect.size.width>videoV.frame.size.width/2) {
                
                                            if (!videoV.isPlaying) {//只播放一个可见视频
                                                for (VideoView* v in self.playViews) {
                                                    if (v.isPlaying ) {
                                                       [v stop];
                                                    }
                                                }
                                                     [videoV play];
                                                return;
                                            }else{
                                                return;
                                            }
                
//                if (!videoV.isPlaying) {//可见都播放
//                    [videoV play];
//                }
                
            }else{
                if (videoV.isPlaying) {
                    [videoV stop];
                }
                
            }
        }
    }
}
@end
