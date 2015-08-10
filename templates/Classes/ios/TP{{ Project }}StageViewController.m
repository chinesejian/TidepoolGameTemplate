//
//  TP{{Project}}StageViewController.m
//  TP{{Project}}
//
//  Created by {{ author }} on {{ currentDate }}.
//  Copyright (c) 2014 Tidepool. All rights reserved.
//

#import "TP{{Project}}StageViewController.h"
#import "TP{{Project}}Scene.h"

static const NSUInteger kRoundPerLevel = 1;

@interface TP{{Project}}StageViewController () <TP{{Project}}SceneDelegate>

@property (nonatomic) NSUInteger round;
@property (nonatomic, weak) TP{{Project}}Scene *{{project}}Scene;

@end

@implementation TP{{Project}}StageViewController

- (void)loadView
{
  SKView *skView = [[SKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  skView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  self.view = skView;
}

- (void)setPaused:(BOOL)paused
{
  if (super.paused != paused) {
    super.paused = paused;
    self.{{project}}Scene.paused = paused;
    self.{{project}}Scene.view.paused = paused;
  }
}

- (void)configureScene
{
  self.{{project}}Scene.paused = YES;
  self.{{project}}Scene.paused = self.paused;
  self.{{project}}Scene.view.paused = self.paused;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  if (!self.{{project}}Scene) {
    SKView *skView = (SKView *)self.view;
    TP{{Project}}Scene *scene = [TP{{Project}}Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeResizeFill;
    [skView presentScene:_{{project}}Scene = scene];
    scene.{{project}}delegate = self;
    [self configureScene];
  }
}

- (BOOL)shouldBeReused
{
  return YES;
}

#pragma mark - TP{{Project}}SceneDelegate

- (void){{project}}SceneLose:(TP{{Project}}Scene *)scene
{
  [self showGraphicForResultCorrect:NO completion:^{
    [self stageOverSuccess:NO];
  }];
}

- (void){{project}}SceneWin:(TP{{Project}}Scene *)scene completion:(dispatch_block_t)completion
{
  self.gameVC.score += 100;
  [self showGraphicForResultCorrect:YES completion:^{
    if (++self.round == kRoundPerLevel) {
      self.round = 0;
      [self stageOverSuccess:YES];
    }
    else {
      [self configureScene];
    }
    if (completion) completion();
  }];
}

- (void)logEvent:(NSDictionary *)properties
{
  [self.gameVC logEventWithProperties:properties];
}

- (BOOL)shouldAutorotate
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}

@end
