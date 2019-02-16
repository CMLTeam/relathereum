#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "GoogleMaps/GoogleMaps.h"

@interface AppDelegate : FlutterAppDelegate
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyAZlNFjWYqHW7SL0hDysQi_M_9lOg-G2gY"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end