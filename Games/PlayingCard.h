//
//  PlayingCard.h
//  Matchismo
//
//  Created by Robert Walker on 2/5/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
