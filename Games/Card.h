//
//  Card.h
//  Matchismo
//
//  Created by Robert Walker on 2/5/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnPlayable) BOOL unplayable;
- (int)match:(NSArray *)otherCards;
@end
