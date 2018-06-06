//
//  MyCell.m
//  瀑布流
//
//  Created by ZLWL on 2018/6/5.
//  Copyright © 2018年 iOSteam. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell


- (void)setShop:(MyWaterfall *)shop{
    
    _shop = shop;
    NSLog(@"%@----%@",MyCell.class,shop);
    // 图片
    [self.imggeV sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    // 价格
    self.lb_text.text = shop.price;
}

@end
