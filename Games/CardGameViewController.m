//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Walker on 2/5/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) UIImage *cardBack;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game
{
    if (!_game) {
        // 2 card matching game
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                       usingDeck:[[PlayingCardDeck alloc]init]];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected];
        [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1.0;
        [cardButton setImage:(card.isFaceUp ? nil : self.cardBack) forState:UIControlStateNormal];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultsLabel.text = self.game.resultsStr;

}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

// Deal a new set of cards
- (IBAction)newDeal:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

// Flip the card and look for any matches
- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardBack = [UIImage imageNamed:@"Kids.png"];
    [self updateUI];
}
@end
