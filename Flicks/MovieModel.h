//
//  MovieModel.h
//  Flicks
//
//  Created by Hrishi Mantri on 1/23/17.
//  Copyright © 2017 Yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSURL *posterUrl;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, strong) NSURL *posterUrlHighResolution;
@end
