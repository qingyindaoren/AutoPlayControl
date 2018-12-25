//
//  VideoView.m
//  TestTable
//
//  Created by mc on 2018/11/5.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "VideoView.h"
#import "YKPlayControl.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 255)
@interface VideoView ()
@property(nonatomic,weak)UIScrollView *scrollV;
@property(nonatomic,strong) UILabel *playLable;
@end
@implementation VideoView
-(instancetype)init{
    if (self == [super init] ) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        self.backgroundColor = randomColor;
        
    }
    return self;
}
-(void)play{
    self.playing = YES;
    self.playLable = [[UILabel alloc]initWithFrame:self.bounds];
    self.playLable.text = @"播放";
    self.playLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.playLable];
}
-(void)stop{
    self.playing = NO;
    [self.playLable removeFromSuperview];
    self.playLable = nil;
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview == nil) {
        if ([[YKPlayControl sharePlayControl].playViews containsObject:self]) {
            [[YKPlayControl sharePlayControl].playViews removeObject:self];
        }
        if ([[YKPlayControl sharePlayControl].playViewsUnScroll containsObject:self]) {
            [[YKPlayControl sharePlayControl].playViewsUnScroll removeObject:self];
        }
        return;
    }
    
//  NSLog(@"%d %@" ,[self isDisplayedInScroll],self)  ;
        UIView *superView = self.superview;

            while (![superView isKindOfClass:[UIScrollView class]]) {
                superView = superView.superview;
                if ([superView isMemberOfClass:[UIWindow class]]) {//不能滑动以window为交叉view
//                    break;
                    if ([self isDisplayedInScreen]) {
                        if (![[YKPlayControl sharePlayControl].playViewsUnScroll containsObject:self]) {
                            [[YKPlayControl sharePlayControl].playViewsUnScroll addObject:self];
                        }
                        [[YKPlayControl sharePlayControl] autoPlayWith:self];
                    }
                    return;
                }
            }
           self.scrollV = (UIScrollView*)superView;//可以滑动，以scrollview为交叉view
    if ([self isDisplayedInScroll]) {//可见
//        CGRect rect=   [self convertRect:self.frame toView:self.scrollV];
//        NSLog(@"位置%@",NSStringFromCGRect(rect) );
        if (![[YKPlayControl sharePlayControl].playViews containsObject:self]) {
            [[YKPlayControl sharePlayControl].playViews addObject:self];
        }
        
        [YKPlayControl sharePlayControl].scrollV =(UIScrollView*)superView;
    }
   


}
-(BOOL)isDisplayedInScreen{
    //不能滑动以屏幕大小界定
    if(self == nil){
        
        return FALSE;
        
    }
//如果有导航，开发者由于失误把视频藏在导航下播放，那就是bug。永远点击不了或者露部分播放，苹果审核也过不了。所以不用担心导航遮挡的问题，就以屏幕大小计算。
    CGRect screenRect =  [UIScreen mainScreen].bounds;
    
    //转换view对应window的Rect
    
    CGRect rect = [self convertRect:self.frame toView:nil];
    
    if(CGRectIsEmpty(rect) || CGRectIsNull(rect)){
        return FALSE;
        
    }
    
    //若view 隐藏
    
    if(self.hidden){
        return false;
        
    }
    
    //若没有superView
    
    if(self.superview == nil){
        
        return false;
        
    }
    
    
    
    //若size 为CGRectZero
    
    if(CGSizeEqualToSize(rect.size, CGSizeZero)){
        
        return false;
        
    }
    
    
    
    //获取 该view 与window 交叉的Rect
    
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    
    if(CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)){
        return false;
        
    }
    if (intersectionRect.size.width<self.frame.size.width/2 || intersectionRect.size.height<self.frame.size.height/2) {
        return false;
    }
    
    return true;
    
}
-(BOOL)isDisplayedInScroll{

    if(self == nil){

        return FALSE;

    }

    CGRect scrollRect = self.scrollV.bounds;

    //转换view对应scorll的Rect

    CGRect rect = [self convertRect:self.frame toView:self.scrollV];

    if(CGRectIsEmpty(rect) || CGRectIsNull(rect)){
        return FALSE;

    }

    //若view 隐藏

    if(self.hidden){
        return false;

    }

    //若没有superView

    if(self.superview == nil){

        return false;

    }



    //若size 为CGRectZero

    if(CGSizeEqualToSize(rect.size, CGSizeZero)){

        return false;

    }



    //获取 该view 与window 交叉的Rect

    CGRect intersectionRect = CGRectIntersection(rect, scrollRect);

    if(CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)){
        return false;

    }

    return true;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
