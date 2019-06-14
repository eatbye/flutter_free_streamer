#import "FlutterFreeStreamerPlugin.h"
#import <flutter_free_streamer/flutter_free_streamer-Swift.h>

@implementation FlutterFreeStreamerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFreeStreamerPlugin registerWithRegistrar:registrar];
}
@end
