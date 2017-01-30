//
//  MovieModel.m
//  Flicks
//
//  Created by Hrishi Mantri on 1/23/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-dd"];
        self.releaseDate = [dateFormatter dateFromString:dictionary[@"release_date"]];
        self.title = dictionary[@"original_title"];
        self.movieDescription = dictionary[@"overview"];
        NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", dictionary[@"poster_path"]];
        NSString *highResolutionUrlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", dictionary[@"poster_path"]];
        self.posterUrl = [NSURL URLWithString:urlString];
        self.posterUrlHighResolution = [NSURL URLWithString:highResolutionUrlString];
    }
    return self;
}

@end
