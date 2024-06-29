#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <SocketRocket/SocketRocket.h>
#import <Firebase.h>

@interface AppDelegate () <SRWebSocketDelegate>
@property (strong, nonatomic) SRWebSocket *webSocket;
@property (strong, nonatomic) FlutterMethodChannel *nativeChannel;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    self.nativeChannel = [FlutterMethodChannel
            methodChannelWithName:@"soundar/helper"
                  binaryMessenger:controller];

    __weak typeof(self) weakSelf = self;
    [self.nativeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"connectWebSocket" isEqualToString:call.method]) {
            [weakSelf connectWebSocket];
            result(@"WebSocket Connected");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)connectWebSocket {
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080/"]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    [self.nativeChannel invokeMethod:@"updateFromNative" arguments:message];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"WebSocket Connected");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"WebSocket Failed With Error %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed with reason: %@", reason);
}

@end
