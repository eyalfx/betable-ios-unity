#import "BetableUnity.h"
#import <Betable/Betable.h>
#import "UnityViewControllerBase.h"
#import "UnityAppController.h"


// convenience methods to convert between c string and NSString*. You need to return a copy of the c string so that Unity handles the memory and gets a valid value.

char* cStringCopy(const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    
    return res;
}

// This takes a char* you get from Unity and converts it to an NSString* to use in your objective c code. 
static NSString* CreateNSString(const char* string)
{
    if (string != NULL)
        return [NSString stringWithUTF8String:string];
    else
        return [NSString stringWithUTF8String:""];
}


BetableAccessTokenHandler authCompleteHandler = ^(NSString* accessToken){
    NSLog(@"accessToken: %@", accessToken);
    if (accessToken) {
        //[self alertAuthorized];
    } else {
        //[self alertAuthorizeFailed];
    }
};
BetableFailureHandler authFailureHandler = ^(NSURLResponse *response, NSString *responseBody, NSError *error){
    NSLog(@"%@", error);
};
BetableCancelHandler authCancelHandler = ^{
    NSLog(@"authCancelHandler");
    //[overlayView removeFromSuperview];
};

extern "C" {
    Betable *betable;
    
    void _init(){
        
        NSLog(@"_init: ");
        
        betable = [[Betable alloc] initWithClientID:@"YOUR_CLIENT_ID"
                                       clientSecret:(NSString*)@"YOUR_CLIENT_SECRET"
                                        redirectURI:(NSString*)@"CALLBACK_URL"]; 
    }
 
    
    char* _authorize()
    {
        NSLog(@"_authorize: ");
        
        [betable authorizeInViewController:[(UnityAppController*)[UIApplication sharedApplication].delegate rootViewController]
                   onAuthorizationComplete:authCompleteHandler
                                 onFailure:authFailureHandler
                                  onCancel:authCancelHandler];
        
        NSString *result = @"betable _authorize";
        return cStringCopy([result UTF8String]);
    }
    
    char* _handleAuthorizeURL(const char* urlChar){
        NSString *urlstr = CreateNSString(urlChar);
        NSLog(@"_handleAuthorizeURL: %@", urlstr);
        NSURL *url = [NSURL URLWithString:urlstr];
        
        [betable handleAuthorizeURL:url];
        NSString *result = @"betable _handleAuthorizeURL";
        return cStringCopy([result UTF8String]);
    }
    char* _unbackedAuthorize(){
        NSLog(@"_unbackedAuthorize: ");
        NSString *result = @"betable _unbackedAuthorize";
        return cStringCopy([result UTF8String]);
    }
    char* _bet(const char* dictChar){
        NSLog(@"_bet: %s", dictChar);
        
        NSString *dictStr = CreateNSString(dictChar);
        NSError *e;
        NSDictionary *data =
        [NSJSONSerialization JSONObjectWithData: [dictStr dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
        
        [betable betForGame:@"YOUR_GAME_ID"
                   withData:data
                 onComplete:^(NSDictionary *data){
                     NSLog(@"%@", data);
                 }
                  onFailure:^(NSURLResponse *response, NSString *responseBody, NSError *error){
                      NSLog(@"%@", responseBody);
                  }];
        
        
        NSString *result = @"betable _bet";
        return cStringCopy([result UTF8String]);
    }
    char* _unbackedBet(){
        NSLog(@"_unbackedBet: ");
        NSString *result = @"betable _unbackedBet";
        return cStringCopy([result UTF8String]);
    }
    char* _creditBet(){
        NSLog(@"_creditBet: ");
        NSString *result = @"betable _creditBet";
        return cStringCopy([result UTF8String]);
    }
    char* _unbackedCreditBet(){
        NSLog(@"_unbackedCreditBet: ");
        NSString *result = @"betable _unbackedCreditBet";
        return cStringCopy([result UTF8String]);
    }
    char* _batchedBet(){
        NSLog(@"_batchedBet: ");
        NSString *result = @"betable _batchedBet";
        return cStringCopy([result UTF8String]);
    }
    char* _account(){
        NSLog(@"_account");
        NSString *result = @"betable _account";
        return cStringCopy([result UTF8String]);
    }
    char* _wallet(){
        NSLog(@"_wallet: ");
        NSString *result = @"betable _wallet";
        return cStringCopy([result UTF8String]);
    }
    char* _profile(){
        NSLog(@"_profile: ");
        NSString *result = @"betable _profile";
        return cStringCopy([result UTF8String]);
    }
    char* _logout(){
        NSLog(@"_logout: ");
        NSString *result = @"betable _logout";
        return cStringCopy([result UTF8String]);
    }
    
    
  }

