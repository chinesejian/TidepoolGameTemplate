//
//  TP{{Project}}GameViewController.m
//  TP{{Project}}
//
//  Created by {{ author }} on {{ currentDate }}.
//  Copyright (c) 2014 Tidepool. All rights reserved.
//

#import "TP{{Project}}GameViewController.h"
#import "TP{{Project}}StageViewController.h"
#import "TP{{Project}}.h"

@interface TP{{Project}}GameViewController ()
@end

@implementation TP{{Project}}GameViewController

- (void)viewDidLoad
{
  self.StageClass = [TP{{Project}}StageViewController class];
  // TODO init numbers
  [super viewDidLoad];
}

- (void)configureStage:(TP{{Project}}StageViewController *)stage forLevel:(int)level
{
  [super configureStage:stage forLevel:level];
  [stage configureScene];
}


@end
