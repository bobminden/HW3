//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Robert Walker on 2/6/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (strong, nonatomic, readwrite) NSMutableArray *cards;  // of Card
@property (nonatomic, readwrite) int score;
@property (nonatomic, strong, readwrite) NSString * resultsStr;
@end

@implementation CardMatchingGame

/* Adding a comment to see if you see it*/

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i <= cardCount; i++) {
            Card * card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnPlayable) {
        self.resultsStr = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        // see if flipping causes a match
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        matchScore *= MATCH_BONUS;
                        self.score = matchScore;
                        self.resultsStr = [NSString stringWithFormat:@"%@  %@ matched for %d points"
                                           ,card.contents, otherCard.contents, matchScore];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.resultsStr = [NSString stringWithFormat:@"%@  %@ don't match. -%d penalty.",
                                           card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}
@end
