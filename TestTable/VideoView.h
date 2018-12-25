//
//  VideoView.h
//  TestTable
//
//  Created by mc on 2018/11/5.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView
@property(nonatomic,getter=isPlaying)BOOL playing;
-(void)play;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
