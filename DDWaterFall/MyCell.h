//
//  MyCell.h
//  瀑布流
//
//  Created by ZLWL on 2018/6/5.
//  Copyright © 2018年 iOSteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWaterfall;

@interface MyCell : UICollectionViewCell

@property (nonatomic, strong) MyWaterfall * shop;

@property (weak, nonatomic) IBOutlet UIImageView *imggeV;

@property (weak, nonatomic) IBOutlet UILabel *lb_text;

@end
