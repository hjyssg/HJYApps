//
//  TBITCommon.h
//
//  Created by junyang_huang on 7/5/13.
//  Copyright (c) 2014. All rights reserved.
//

#ifndef iWOC_Common_h
#define iWOC_Common_h

#define UNIT_CHOICE_PROPRTY_KEY @"UNIT_CHOICE_PROPRTY_KEY"
#define SEND_DATA_BACK_TO_SERVER_PROPERTY_KEY @"SEND_DATA_BACK_TO_SERVER_PROPERTY_KEY"

#define METER_TO_FEET(a)  a*3.28084
#define CELSIUS_TO_F(c) c *(9.0/5.0) + 32.0

#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#else
#define DLog(...) do { } while (0)
#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif
#define ALog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#define ZAssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)
#endif

#endif
