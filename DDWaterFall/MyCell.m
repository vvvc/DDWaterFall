//
//  MyCell.m
//  瀑布流
//
//  Created by ZLWL on 2018/6/5.
//  Copyright © 2018年 iOSteam. All rights reserved.
//

#import "MyCell.h"


@interface MyCell ()

@property (strong, nonatomic) UIImageView *imageV;

@property (strong, nonatomic) UILabel *lb_text;

@end

@implementation MyCell


- (void)setShop:(MyWaterfall *)shop{
    
    _shop = shop;
    NSLog(@"%@----%@",MyCell.class,shop);
    // 图片
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    // 价格
    self.lb_text.text = shop.price;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self configSubviews];
    }
    return self;
}
-(void)configSubviews
{
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    [self addSubview:_imageV];
    _lb_text = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
    _lb_text.text = @"aaaaasdsdss";
    [self addSubview:_lb_text];
}

//这个方法极为重要
-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect framea  = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20);
    CGRect frameb =  CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20);
    _imageV.frame = framea;
    _lb_text.frame = frameb;
}

@end
