//
//  TPSideMultipleChoiceQuestionViewController.m
//  Pods
//
//  Created by Timothy on 10/31/14.
//
//

#import "TPSideMultipleChoiceQuestionViewController.h"
#import <UIKit/UIKit.h>

@interface TPSideMultipleChoiceQuestionViewController ()

@property (weak, nonatomic) IBOutlet UIView *sideContainerView;
@property (weak, nonatomic) IBOutlet UIView *descContainerView;
@property (weak, nonatomic) IBOutlet UIView *choiceContainerView;

@end

@implementation TPSideMultipleChoiceQuestionViewController

- (void)viewDidLoad {
  NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem: _sideContainerView
                                                       attribute: NSLayoutAttributeWidth
                                                       relatedBy: NSLayoutRelationEqual
                                                          toItem: self.view
                                                       attribute: NSLayoutAttributeWidth
                                                      multiplier: 0.5
                                                        constant: 0];
  [self.view addConstraint:c];
  
  NSLayoutConstraint *d = [NSLayoutConstraint constraintWithItem: _descContainerView
                                                       attribute: NSLayoutAttributeHeight
                                                       relatedBy: NSLayoutRelationEqual
                                                          toItem: _sideContainerView
                                                       attribute: NSLayoutAttributeHeight
                                                      multiplier: 0.333
                                                        constant: 0];
  [_sideContainerView addConstraint:d];
  
  for (int i=0; i<self.numChoices; i++) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    button.tag = kQuizButtonOffset+i;
    [_choiceContainerView addSubview:button];
    
    UIFont * customFont = [UIFont fontWithName:@"Karla-Bold" size:13];
    UILabel *label = [[UILabel alloc] init];
    label.font = customFont;
    label.tag = kQuizLabelOffset+i;
    label.numberOfLines = 3;
    label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    label.adjustsFontSizeToFitWidth = YES;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [_choiceContainerView addSubview:label];
  }
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
  CGFloat cellHeight = floorf((_choiceContainerView.frame.size.height-(self.numChoices-1))/self.numChoices);
  CGFloat cellWidth = _choiceContainerView.frame.size.width;
  
  for (int i=0; i<self.numChoices; i++) {
    UIButton *button = self.choiceUIButtons[i];
    button.frame = CGRectMake(0.0, cellHeight*i+i, cellWidth, cellHeight);
    
    UILabel *label = self.choiceUILabels[i];
    label.frame = CGRectMake(8, cellHeight*i+i+8, cellWidth-16, cellHeight-16);
  }
}


@end
