//
//  AlipayHelper.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-14.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AlipayHelper.h"
#import "EnsureViewController.h"

#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"

@implementation AlipayHelper


//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
    {
        
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                NSLog(@"支付成功");
                [self paySuccess];
                //验证签名成功，交易结果无篡改
			}
        }
        else
        {
            
            [self payFailed];//交易失败
        }
    }
    else
    {
        
        [self payFailed];//交易失败
    }
    
}


-(void)paySuccess
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"恭喜" message:@"您已充值成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];

    if (_success) {
        _success();
    }
    
    
}

-(void)payFailed
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    
    if (_failure) {
        _failure();
    }
    
    
}


-(void)pay:(AlixPayOrder*)order
{
    //异步付款
    NSString *appScheme = AppScheme;
    
    order.partner = PartnerID;
    order.seller = SellerID;
    
	order.productDescription = @"充值"; //商品描述
	order.notifyURL =  AlipayReturnUrl; //回调URL
    order.tradeNO = [self generateTradeNO:order]; //订单ID（由商家自行制定）
    if (order.tradeNO==nil || order.tradeNO.length<10) {
        return;
    }
    NSString* orderInfo = [order description];
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
    });
    
}


-(NSString*)generateTradeNO:(AlixPayOrder*)order
{
    NSString *tradeNo = nil;//订单号
//    NSString *token = [User shareUser].token;
    long uid = [User shareUser].manID ;
    NSString *fee = order.amount;

    NSString *url_str = [NSString stringWithFormat:@"%@?id=%ld&fee=%@",PORT_ALIPAYRECHARGE,uid,fee];
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    tradeNo =dict[@"data"];
    return tradeNo;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

#pragma mark - Class method Pay
+(void)payOrder:(AlixPayOrder*)product inView:(UIView*)view paySuccess:(void (^)())success payFailure:(void (^)())failure;
{
    
    static AlipayHelper *payer = nil;
    if (payer==nil) {
        payer = [[AlipayHelper alloc]init];
    }
    payer.view = view;
    payer.result = @selector(paymentResult:);
    payer->_success = success;
    payer->_failure = failure;
    [MBProgressHUD show:@"loading" icon:nil view:payer.view];
    [payer performSelectorInBackground:@selector(pay:) withObject:product];//充值
   
}
@end
