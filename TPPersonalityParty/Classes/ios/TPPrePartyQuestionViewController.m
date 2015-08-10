//
//  TPPrePartyQuestionViewController.m
//  Pods
//
//  Created by Timothy on 10/30/14.
//
//

#import "TPPrePartyQuestionViewController.h"

@interface TPPrePartyQuestionViewController ()

@end

@implementation TPPrePartyQuestionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  for (UIButton *button in self.choiceUIButtons) {
    button.layer.cornerRadius = button.frame.size.height/2;
  }
}

@end
