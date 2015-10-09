//
//  LXImagesCell.m
//  自定义collectionView布局
//
//  Created by ma c on 15/10/9.
//  Copyright (c) 2015年 梁学. All rights reserved.
//

#import "LXImagesCell.h"
@interface LXImagesCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation LXImagesCell

- (void)setImage:(NSString *)image{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

- (void)awakeFromNib {

    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.clipsToBounds = YES;
}

@end
