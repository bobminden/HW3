//
//  SetMatchingGame.m
//  Games
//
//  Created by Robert Walker on 2/14/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "SetMatchingGame.h"


@interface SetMatchingGame()
@property (strong, nonatomic, readwrite) NSMutableArray *cards;  // of Card
@property (nonatomic, readwrite) int score;
@property (nonatomic, strong, readwrite) NSString * resultsStr;
@end

@implementation SetMatchingGame

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

#define MATCH_BONUS 8
#define MISMATCH_PENALTY 2
#define SUIT_BONUS 3
#define FLIP_COST 1

// faceup means in comparison
// unPlayable means already in a match, so make hidden.

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnPlayable) {
        // see if flipping causes a match
        if (!card.isFaceUp) {
            self.resultsStr = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            NSLog(@"Looking for two faceup");
            // Find two other cards that are face up and playable
            NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
            for (Card *c in self.cards) {
                if (c.isFaceUp && !c.isUnPlayable) {
                    NSLog(@"found one");
                    [faceUpCards addObject:c];
                }
            }
            
            if ([faceUpCards count] == 2) {
                Card *card1 = faceUpCards[0];
                Card *card2 = faceUpCards[1];
                int matchScore = [card match:faceUpCards];
                NSLog(@"matchScore %d", matchScore);
                if (matchScore == 0) {
                    // no matches
                    self.score -= MISMATCH_PENALTY;
                    card1.faceUp = NO;
                    card2.faceUp = NO;
                    self.resultsStr = [NSString stringWithFormat:@"%@ %@ %@ No Match. %d penalty",
                                           card.contents, card1.contents, card2.contents, MISMATCH_PENALTY];
                } else {
                    // 3 match rank
                    matchScore *= MATCH_BONUS;
                    self.score += matchScore;
                    card.unplayable = YES;
                    card1.unplayable = YES;
                    card2.unplayable = YES;
                    self.resultsStr =[NSString stringWithFormat:@"%@ %@ %@ match for %d points",
                                          card.contents, card1.contents, card2.contents, matchScore];
                }
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
