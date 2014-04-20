//
//  PSNetAtmoMeasureDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSNetAtmoModuleMeasure+Helper.h"

@implementation PSNetAtmoModuleMeasure (Helper)

- (id) initWithData:(NSData*)data error:(NSError **)error
{
    DLogFuncName();
    self = [super init];
    if(self)
    {
        //        {"status":"ok","body":{"_id":"5165a31f187759e7a1000035","administrative":{"country":"DE","reg_locale":"de-DE","lang":"de-DE","unit":0,"windunit":0,"pressureunit":0,"feel_like_algo":0},"date_creation":{"sec":1365615391,"usec":0},"devices":["70:ee:50:00:51:26"],"mail":"info@philip-schneider.com","timeline_not_read":0},"time_exec":1.4236359596252,"time_server":1385229859}
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        NSLog(@"ParsedObject = %@", parsedObject);
        
        if (localError != nil) {
            *error = localError;
            return nil;
        }
        
//        self.devices = [[parsedObject objectForKey:@"body"] objectForKey:@"devices"];
    }
    return self;
}






@end
