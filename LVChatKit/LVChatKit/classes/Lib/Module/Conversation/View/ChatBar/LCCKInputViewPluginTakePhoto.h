//
//  LCCKInputViewPluginTakePhoto.h
//  Pods
//
//  v0.8.2 Created by ElonChan (微信向我报BUG:chenyilong1010) on 16/8/11.
//
//

#if __has_include(<ChatKit/LCChatKit.h>)
#import <ChatKit/LCChatKit.h>
#else
#import "LCChatKit.h"
#endif

@interface LCCKInputViewPluginTakePhoto : LCCKInputViewPlugin<LCCKInputViewPluginSubclassing>

@property (nonatomic, weak) LCCKChatBar *inputViewRef;

@end
