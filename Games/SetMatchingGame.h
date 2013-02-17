//
//  SetMatchingGame.h
//  Games
//
//  Created by Robert Walker on 2/14/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SetMatchingGame : NSObject
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (strong, nonatomic, readonly) NSMutableArray *cards;  // of Card
@property (nonatomic, readonly) int score;
@property (nonatomic, strong, readonly) NSString * resultsStr;
@end
