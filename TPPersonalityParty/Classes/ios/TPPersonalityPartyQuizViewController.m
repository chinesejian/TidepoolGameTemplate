//
//  TPPersonalityPartyQuizViewController.m
//  Pods
//
//  Created by Timothy on 10/17/14.
//
//

#import "TPPersonalityPartyQuizViewController.h"


@interface TPPersonalityPartyQuizViewController ()

@end


@implementation TPPersonalityPartyQuizViewController

-(void)commonInit
{
  [super commonInit];
}


-(NSString *)jsonFilename
{
  return @"personalityparty_data";
}


-(void) viewDidLoad
{
  [super viewDidLoad];
}


-(NSArray *)tiedHollandSixArray
{
  int maxValue = 0;
  NSArray *keys = @[@"realistic", @"investigative", @"artistic", @"social", @"enterprising", @"conventional"];
  NSMutableArray *objects = [NSMutableArray array];
  
  for (NSString *key in keys) {
    NSNumber *number = self.quizFlags[key];
    if (number != nil) {
      [objects addObject:number];
      maxValue = MAX(maxValue, number.intValue);
    }
  }
  
  NSArray *filtered = [objects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.intValue == %d", maxValue]];
  return filtered;
}


-(BOOL)hollandSixTie
{
  NSArray *filtered = [self tiedHollandSixArray];
  return filtered.count >= 2 ? YES : NO;
}


-(BOOL)hollandSixTie:(id)object
{
  NSString *key = [((NSDictionary *)object)objectForKey:@"key"];
  NSNumber *the1 = self.quizFlags[key];
  NSArray *filtered = [self tiedHollandSixArray];
  if ([filtered indexOfObject:the1] != NSNotFound) {
    return YES;
  }
  return NO;
}

-(NSArray *)tiedBigFiveArray
{
  int maxValue = 0;
  NSArray *keys = @[@"openness", @"agreeableness", @"conscientiousness", @"neuroticism", @"extraversion"];
  NSMutableArray *objects = [NSMutableArray array];
  
  for (NSString *key in keys) {
    NSNumber *number = self.quizFlags[key];
    if (number != nil) {
      [objects addObject:number];
      maxValue = MAX(maxValue, abs(number.intValue));
    }
  }
  
  NSArray *filtered = [objects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"abs(self.intValue) == %d", maxValue]];
  return filtered;
}


-(BOOL)bigFiveTie
{
  NSArray *filtered = [self tiedBigFiveArray];
  return filtered.count >= 2 ? YES : NO;
}


-(BOOL)bigFiveTie:(id)object
{
  NSString *key = [((NSDictionary *)object)objectForKey:@"key"];
  BOOL isHigh = [[((NSDictionary *)object)objectForKey:@"isHigh"] boolValue];
  NSNumber *the1 = self.quizFlags[key];
  NSArray *filtered = [self tiedBigFiveArray];
  if ([filtered indexOfObject:the1] != NSNotFound) {
    int variableInt = the1.intValue;
    if (variableInt > 0 == isHigh) {
      return YES;
    }
  }
  return NO;
}

@end
