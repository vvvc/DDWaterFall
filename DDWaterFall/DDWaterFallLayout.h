//
//  DDWaterFallLayout.h
//  瀑布流
//
//  Created by ZLWL on 2018/6/6.
//  Copyright © 2018年 iOSteam. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DDWaterFallLayout;

@protocol DDWaterFallLayoutDelegate <NSObject>
/**  根据  cell  的宽度计算  cell  的高度 */
- (CGFloat)waterFallLayout:(DDWaterFallLayout *)waterFallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

#pragma mark -- collectionView 有头部\底部视图时要求实现
@optional
/**  collectionView  头部视图的尺寸 */
- (CGSize)waterflowLayout:(DDWaterFallLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath;
/**  collectionView  底部视图的尺寸 */
- (CGSize)waterflowLayout:(DDWaterFallLayout *)waterflowLayout sectionFooterAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DDWaterFallLayout : UICollectionViewLayout

@property (assign, nonatomic) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;
/** 代理 */
@property (weak, nonatomic) id<DDWaterFallLayoutDelegate> delegate;





@end
