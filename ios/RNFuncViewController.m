//
//  RNFuncViewController.m
//  BundleSeparate
//
//  Created by Hays on 27/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNFuncViewController.h"
#import <React/RCTRootView.h>
#import "DiffMatchPatch.h"

@interface RNFuncViewController ()<RCTBridgeDelegate>

@property(nonatomic, copy) NSString *moduleName;
@property(nonatomic, copy) NSString *patchName;

@end

@implementation RNFuncViewController

- (instancetype)initWithModuleNamne:(NSString *)moduleName patchName:(NSString *)patchName
{
  self = [super init];
  if (self) {
    self.moduleName = moduleName;
    self.patchName = patchName;
  }
  return self;
}

//- (void)loadView
//{
//  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
//  NSLog(@"module name : %@, bridge : %@", self.moduleName, bridge);
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:self.moduleName initialProperties:nil];
//  self.view = rootView;
//}

- (void)viewDidLoad
{
  [super viewDidLoad];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
  NSLog(@"module name : %@, bridge : %@", self.moduleName, bridge);
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:self.moduleName initialProperties:nil];
  self.view = rootView;
}

#pragma mark - private

- (NSString *)getNewBundle
{
  
  NSString *commonBundlePath = [[NSBundle mainBundle] pathForResource:@"main.ios" ofType:@"jsbundle"];
  NSString *commonBundleJSCode = [[NSString alloc] initWithContentsOfFile:commonBundlePath encoding:NSUTF8StringEncoding error:nil];
  
  NSString *patch1Path = [[NSBundle mainBundle] pathForResource:self.patchName ofType:@"patch"];
  NSString *patch1JSCode = [[NSString alloc] initWithContentsOfFile:patch1Path encoding:NSUTF8StringEncoding error:nil];
  
  
  DiffMatchPatch *diffMatchPatch = [[DiffMatchPatch alloc] init];
  NSError *error;
  NSArray *convertedPatches = [diffMatchPatch patch_fromText:patch1JSCode error:&error];
  if (error != nil) {
    NSLog(@"diff match failed : %@", error);
  }
  
  NSArray *resultsArray = [diffMatchPatch patch_apply:convertedPatches toString:commonBundleJSCode];
  NSString *resultJSCode = resultsArray[0]; //patch合并后的js
  
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docDir = [paths objectAtIndex:0];
  NSString *newPath = [NSString stringWithFormat:@"%@/%@.jsbundle",docDir,self.patchName];
  
  if (resultsArray.count > 1) {
    [resultJSCode writeToFile:newPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    return newPath;
  }
  else {
    return @"";
  }
  
}

#pragma mark - RCTBridgeDelegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  NSString *path = [self getNewBundle];
  NSLog(@"js bundle path : %@", path);
  NSURL *jsBundleURL = [NSURL URLWithString:path];
  
  return jsBundleURL;
}

@end
