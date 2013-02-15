//
//  SetCard.h
//  Games
//
//  Created by Robert Walker on 2/9/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger symbol;
@property (nonatomic) NSInteger fill;
@property (nonatomic) NSInteger color;
@end
