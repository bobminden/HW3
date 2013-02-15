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


// From Joan Carles Catalan
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
        [cardButton setAttributedTitle:[self cardAttributedContents:card] forState:UIControlStateSelected];
        [cardButton setAttributedTitle:[self cardAttributedContents:card] forState:UIControlStateSelected|UIControlStateDisabled];
        //cardButton.selected = card.isFaceUp;
        cardButton.selected = !card.isUnPlayable;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1.0;
      //  [cardButton setImage:(card.isFaceUp ? nil : self.cardBack) forState:UIControlStateNormal];
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
	[self updateUI];
}


@end
