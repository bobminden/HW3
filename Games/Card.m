//
//  Card.m
//  Matchismo
//
//  Created by Robert Walker on 2/5/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
            break;
        }
    }
    return score;
}

@end
