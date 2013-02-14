//
//  SetCard.m
//  Games
//
//  Created by Robert Walker on 2/9/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    if ([otherCards count] != 2) return 0;
         
    int score = 1;
    
    NSMutableSet * countSet = [[NSMutableSet alloc] init];
    NSMutableSet * symbolSet = [[NSMutableSet alloc] init];
    NSMutableSet * colorSet  = [[NSMutableSet alloc] init];
    NSMutableSet * fillSet   = [[NSMutableSet alloc] init];
    
    NSArray * cards = @[self, otherCards[0], otherCards[1]];
    for (SetCard *card in cards) {
        [countSet addObject:card.count];
        [symbolSet addObject:card.symbol];
        [colorSet addObject:card.color];
        [fillSet addObject:card.fill];
    }
    
    if ([countSet count] == 2) score = 0;
    if ([symbolSet count] == 2) score = 0;
    if ([colorSet count] == 2) score = 0;
    if ([fillSet count] == 2) score = 0;
    
    return score;
}

@end
