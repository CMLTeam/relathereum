#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[GMSServices provideAPIKey:@"AIzaSyAZlNFjWYqHW7SL0hDysQi_M_9lOg-G2gY"];

[GeneratedPluginRegistrant registerWithRegistry:self];
// Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
