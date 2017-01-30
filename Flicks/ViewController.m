//
//  ViewController.m
//  Flicks
//
//  Created by Hrishi Mantri on 1/23/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "MovieCollectionViewCell.h"
#import "MovieModel.h"
#import "ScrollViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (strong, nonatomic) NSArray<MovieModel *> *movies;
@property (strong, nonatomic) NSString *urlString;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Add Segment Controller
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"List", @"Grid", nil]];
    [segmentedControl setSelectedSegmentIndex:0];
    self.segmentedControl = segmentedControl;
    [self.segmentedControl addTarget:self action:@selector(onSegmentChange) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    self.networkErrorView.hidden = true;
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";

    // Do any additional setup after loading the view, typically from a nib.
    self.movieTableView.dataSource = self;

    if([@"nowPlaying" isEqualToString:self.restorationIdentifier])
    {
            self.urlString =  [@"https://api.themoviedb.org/3/movie/now_playing?api_key=" stringByAppendingString:apiKey];
    }
    else if ([@"topMovies" isEqualToString:self.restorationIdentifier])
    {
            self.urlString = [@"https://api.themoviedb.org/3/movie/top_rated?api_key=" stringByAppendingString:apiKey];
    }
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.movieTableView insertSubview:self.refreshControl atIndex:0];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat itemHeight = 130;
    CGFloat itemWidth = screenWidth / 3;
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth - 5, itemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"MovieCollectionViewCell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.hidden = YES;
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    [self fetchMovies];
}
-(void)onSegmentChange
{
    if(self.segmentedControl.selectedSegmentIndex == 0) {
        self.collectionView.hidden = YES;
        self.movieTableView.hidden = NO;
    }
    else if(self.segmentedControl.selectedSegmentIndex == 1) {
        self.movieTableView.hidden = YES;
        self.collectionView.hidden = NO;
    }
}

- (void)onRefresh {
    [self fetchMovies];
    [self.refreshControl endRefreshing];
}

-(void)fetchMovies
{
    [MBProgressHUD showHUDAddedTo:self.movieTableView animated:true];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    NSArray *results = responseDictionary[@"results"];
                                                    NSMutableArray *models = [NSMutableArray array];
                                                    for (NSDictionary *result in results) {
                                                        MovieModel *model = [[MovieModel alloc] initWithDictionary:result];
                                                        NSLog(@"Model - %@s",  model);
                                                        [models addObject:model];
                                                        self.movies = models;
                                                        [self.movieTableView reloadData];
                                                        [self.collectionView reloadData];
                                                    }
                                                } else {
                                                    self.networkErrorView.hidden = false;
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [NSThread sleepForTimeInterval:2.0f];
    [MBProgressHUD hideHUDForView:self.movieTableView animated:true];
    self.networkErrorView.hidden = true;
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.title;
    cell.overviewLabel.text = model.movieDescription;
    [cell.posterImageView setImageWithURL:model.posterUrl];
    NSLog(@"row number = %ld", indexPath.row);
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ScrollViewController *destViewController = segue.destinationViewController;
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        NSIndexPath *indexPath = [self.movieTableView indexPathForSelectedRow];
        destViewController.movie = [_movies objectAtIndex:indexPath.row];
    }
    else if(self.segmentedControl.selectedSegmentIndex == 1)
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        destViewController.movie = [_movies objectAtIndex:indexPath.item];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    cell.model = model;
    [cell reloadData];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"nowPlayingSegue" sender:cell];
}

@end
