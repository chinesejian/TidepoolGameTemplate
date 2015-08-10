//
//  TPAppDelegate.m
//  TPPersonalityParty
//
//  Created by Jason Huang on 11/13/14.
//  Copyright (c) 2014 Tidepool. All rights reserved.
//

#import "TPAppDelegate.h"
#import "TPPrePartyQuestionViewController.h"
#import <SpriteKit/SpriteKit.h>
#import <TPServiceFramework/TPSessionService.h>
#import <Crashlytics/Crashlytics.h>
#import <AVFoundation/AVFoundation.h>

@implementation TPAppDelegate
{
  BOOL ignoreNext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  TPSessionService *session = [TPSessionService sharedInstance];
  [session initializeSession];
  
  TPPrePartyQuestionViewController *rootViewController = [[TPPrePartyQuestionViewController alloc] init];
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  ignoreNext = YES;
  return YES;
}

static BOOL isAudioSessionActive = NO;

- (void)startAudio
{
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  NSError *error = nil;
  
  if (audioSession.otherAudioPlaying) {
    [audioSession setCategory: AVAudioSessionCategoryAmbient error:&error];
  } else {
    [audioSession setCategory: AVAudioSessionCategorySoloAmbient error:&error];
  }
  
  if (!error) {
    [audioSession setActive:YES error:&error];
    isAudioSessionActive = YES;
  }
  
  NSLog(@"%s AVAudioSession Category: %@ Error: %@", __FUNCTION__, [audioSession category], error);
}

- (void)stopAudio
{
  // Prevent background apps from duplicate entering if terminating an app.
  if (!isAudioSessionActive) return;
  
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  NSError *error = nil;
  
  [audioSession setActive:NO error:&error];
  
  NSLog(@"%s AVAudioSession Error: %@", __FUNCTION__, error);
  
  if (error) {
    // It's not enough to setActive:NO
    // We have to deactivate it effectively (without that error),
    // so try again (and again... until success).
    [self stopAudio];
  } else {
    isAudioSessionActive = NO;
  }
}

- (void)setPaused:(BOOL)paused
{

}

- (void)applicationWillResignActive:(UIApplication *)application
{
  self.paused = YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  self.paused = YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  self.paused = NO;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  if (ignoreNext) {
    ignoreNext = NO;
  }
  else {
    self.paused = NO;
  }
}

@end
