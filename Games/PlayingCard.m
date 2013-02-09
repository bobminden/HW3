//
//  PlayingCard.m
//  Matchismo
//
//  Created by Robert Walker on 2/5/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
#define SUIT_MATCH 1
#define RANK_MATCH 4

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;

            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = SUIT_MATCH;
            } else if (otherPlayingCard.rank == self.rank) {
                score = RANK_MATCH;
            }
        }
    }
    
    // return codes
    // 0  no match
    // 1  suit match between 2 cards
    // 2  rank match between 2 cards
    // 3  suit match between 3 cards
    // 4  rank match between 3 cards
    if ([otherCards count] == 2) {
        int num;
        PlayingCard * card1 = otherCards[0];
        PlayingCard * card2 = otherCards[1];
        
        if (card1.rank == self.rank && card2.rank == self.rank) {
            score = 5;
            
        } else if ([card1.suit isEqualToString:self.suit]
                   && [card2.suit isEqualToString:self.suit]) {
            score = 4;
            
        } else {
            num = [self match:@[card1]];
            if (num == RANK_MATCH) {
                score = 2;
            } else if (num == SUIT_MATCH) {
                score = 1;
            }
            
            // reason to add scores:  it is possible to have 2 rank match and 2 suit match, etc.
            num = [self match:@[card2]];
            if (num == RANK_MATCH) {
                score += 2;
            } else if (num == SUIT_MATCH) {
                score += 1;
            }
            
            num = [card1 match:@[card2]];
            if (num == RANK_MATCH) {
                score += 2;
            } else if (num == SUIT_MATCH) {
                score += 1;
            }
        }
        
    }
    return score;
}
+ (NSArray *)rankStrings
{
    static NSArray * rankStrings = nil;
    if (! rankStrings) {
        rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    }
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (! validSuits) validSuits = @[@"♠",@"♣",@"♥",@"♦"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end

