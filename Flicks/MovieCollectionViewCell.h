//
//  MovieCollectionViewCell.h
//  Flicks
//
//  Created by  Hrishi Mantri on 1/26/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MovieModel *model;

- (void)reloadData;

@end
