//
//  SetCardDeck.m
//  Games
//
//  Created by Robert Walker on 2/9/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (id) init
{
    self = [super init];
    
    if (self) {
        for (int symbol = 0; symbol <= 2; ++symbol) {
            for (int count = 1; count <= 3; ++count) {
                for (int color = 0; color <= 2; ++color) {
                    for (int fill = 0; fill <= 2; ++fill) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.count = count;
                        card.fill = fill;
                        card.color = color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}
@end
