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
@property (strong, nonatomic) NSNumber * count;
@property (strong, nonatomic) NSNumber * symbol;
@property (strong, nonatomic) NSNumber * fill;
@property (strong, nonatomic) NSNumber * color;
@end
