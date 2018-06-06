//
//  MyWaterfall.h
//  Recruit
//
//  Created by ZLWL on 2018/6/5.
//  Copyright © 2018年 陈晓晶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWaterfall : NSObject

/** 宽度  */
@property (nonatomic, assign) CGFloat w;
/** 高度  */
@property (nonatomic, assign) CGFloat h;
/** 图片  */
@property (nonatomic, copy) NSString *img;
/** 价格  */
@property (nonatomic, copy) NSString *price;

@end
