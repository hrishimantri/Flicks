//
//  ScrollViewController.m
//  Flicks
//
//  Created by Hrishi Mantri on 1/24/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import "ScrollViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ScrollViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *descriptionScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = _movie.title;
    [self.posterImageView setImageWithURL:_movie.posterUrlHighResolution];
    self.overviewLabel.text = _movie.movieDescription;
    [self.overviewLabel sizeToFit];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:_movie.releaseDate];
    NSLog(@"%@",_movie.releaseDate);
    
//    self.descriptionScrollView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
//    CGFloat contentOffsetY = 180 + CGRectGetHeight(self.cardView.bounds);
    self.descriptionScrollView.contentSize = CGSizeMake(self.descriptionScrollView.bounds.size.width, 600);
//    self.descriptionScrollView.backgroundColor = [UIColor yellowColor];
//    self.cardView.backgroundColor = [UIColor yellowColor];
    
    [self.descriptionScrollView addSubview:_overviewLabel];
    [self.view addSubview:self.descriptionScrollView];

};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
