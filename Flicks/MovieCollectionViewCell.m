//
//  MovieCollectionViewCell.m
//  Flicks
//
//  Created by  Hrishi Mantri on 1/26/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface  MovieCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation MovieCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

-(void)reloadData
{
    [self.imageView setImageWithURL:self.model.posterUrl];
    // makes sure layoutsubviews is called
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //image view is the same as cell size
    self.imageView.frame = self.contentView.bounds;
}

@end
