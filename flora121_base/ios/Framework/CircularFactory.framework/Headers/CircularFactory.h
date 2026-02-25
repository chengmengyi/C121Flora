//
//  CircularFactory.h
//  LuckyGame
//
//  Created by LuckyGame on 2024/12/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@interface CircularFactory : NSObject

+ (CircularFactory *)testTree;

//controller中调用，设置环境
- (void)fixOval:(UIViewController *)rootVC hideVerifier:(UIView *)gameView;

//移除View
- (void)drawCircuit;

//加载BasicConfig
- (void)installMidnight;

//加载OfferConfig if success,load success.
- (void)pulseHouse;

//显示WebView
- (void)resizeSapphire;
@property (nonatomic, strong) WKWebView *eventIcon;
@property (nonatomic, assign) BOOL featurePhoto;
//idfa 请尽量传入
@property (nonatomic, copy) NSString *statusSpace;
//distinctid tba 务必传入
@property (nonatomic, copy) NSString *coreRow;
@end

NS_ASSUME_NONNULL_END
