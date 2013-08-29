betable-ios-unity
=================

Unity3D plugin to communicate with Betable IOS sdk
*****  work in progress  ******
currently you can only authorize a user via the Betable IOS sdk webview which is integrated.
Also, you can send a bet and recieve respond


Instruction:
1.install betable-ios-sdk available on betable github page
2.import the unity package
3.import the plugins into your xCode project
4.edit the plugin and add your clientId clientSecret and gameId
5. add the following to the appDelegate (UnityAppController.mm)

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //send message here
    NSLog(@"handleOpenURL %@", url);
    
    NSString *urlString = [url absoluteString];
    const char *urlChar = [urlString cStringUsingEncoding:NSASCIIStringEncoding];
    UnitySendMessage("BetableMngr", "OnAccessCode", urlChar);
    return YES;
}
