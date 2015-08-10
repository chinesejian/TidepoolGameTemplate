//
//  TP{{Project}}Scene.h
//  TP{{Project}}
//
//  Created by {{ author }} on {{ currentDate }}.
//  Copyright (c) 2014 Tidepool. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class TP{{Project}}Scene;

@protocol TP{{Project}}SceneDelegate <NSObject>

- (void){{project}}SceneLose:(TP{{Project}}Scene *)scene;
- (void){{project}}SceneWin:(TP{{Project}}Scene *)scene completion:(dispatch_block_t)completion;
- (void)logEvent:(NSDictionary *)properties;
- (void){{project}}Scene:(TP{{Project}}Scene *)scene didWinPoints:(int)points;

@end

@interface TP{{Project}}Scene : SKScene

  @property (nonatomic, weak) id<TP{{Project}}SceneDelegate> {{project}}delegate;

@end
