//
//  SetGameViewController.m
//  Games
//
//  Created by Robert Walker on 2/14/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) SetMatchingGame *game;
@property (nonatomic) int flipCount;
@property (strong, nonatomic)UIImage * chosenImage;
@end

@implementation SetGameViewController

- (SetMatchingGame *)game
{
    if (!_game) {
        _game = [[SetMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[[SetCardDeck alloc]init]];
    }
    return _game;
}


- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (NSAttributedString *)cardAttributedContents:(Card *)card
{
    NSArray *colorPallette = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    NSArray *alphaPallette = @[@0,@0.2,@1];
    
    UIColor *cardOutlineColor = colorPallette[((SetCard *)card).color]; 
    UIColor *cardColor = [cardOutlineColor colorWithAlphaComponent:(CGFloat)[alphaPallette[((SetCard *)card).fill] floatValue]];
    
    NSDictionary *cardAttributes = @{NSForegroundColorAttributeName : cardColor, NSStrokeColorAttributeName : cardOutlineColor, NSStrokeWidthAttributeName: @-5};
    
    NSAttributedString *cardContents = [[NSAttributedString alloc] initWithString:card.contents attributes:cardAttributes];
    
    return cardContents;
}

- (void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSAttributedString * desc = [self cardAttributedContents:card];
        [cardButton setAttributedTitle:desc forState:UIControlStateNormal];
        [cardButton setAttributedTitle:desc forState:UIControlStateSelected];
        [cardButton setAttributedTitle:desc forState:UIControlStateSelected|UIControlStateDisabled];
        
        [cardButton setBackgroundImage:(card.isFaceUp ? self.chosenImage:nil) forState:UIControlStateNormal];
        
        cardButton.selected = !card.isUnPlayable;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.0 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.resultsLabel.attributedText = [self turnResults];
    
    if ([self.game aMatchExits] == NO) {
        self.resultsLabel.text = @"GAME OVER";
    }
}

- (NSAttributedString *)turnResults
{
    NSMutableAttributedString * result;
    result = [[NSMutableAttributedString alloc] initWithString:@" "];
    if ([self.game.cardsInTurn count] == 3 && self.game.turnScore != 0) {
        result = [[self cardAttributedContents:self.game.cardsInTurn[0]] mutableCopy];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [result appendAttributedString:[self cardAttributedContents:self.game.cardsInTurn[1]]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [result appendAttributedString:[self cardAttributedContents:self.game.cardsInTurn[2]]];
    
        NSString * desc;
        if ((self.game.turnScore < 0)) {
            desc = [NSString stringWithFormat:@" Mismatch for %d points", self.game.turnScore];
        } else {
            desc = [NSString stringWithFormat:@" Match for %d points", self.game.turnScore];
        }
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:desc]];
    }
    return result;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)showMatch:(UIButton *)sender
{
    if ([self.game aMatchExits] == YES) {
        NSMutableAttributedString * result = nil;
        result = [[self cardAttributedContents:self.game.matchedCards[0]] mutableCopy];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [result appendAttributedString:[self cardAttributedContents:self.game.matchedCards[1]]];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [result appendAttributedString:[self cardAttributedContents:self.game.matchedCards[2]]];
        self.resultsLabel.attributedText = result;
    }
}

- (IBAction)newDeal:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)chooseCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chosenImage = [UIImage imageNamed:@"images-1.jpeg"];
	[self updateUI];
}


@end
