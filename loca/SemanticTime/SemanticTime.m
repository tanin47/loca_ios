//
//  SemanticTime.m
//  foodling2
//
//  Created by Apirom Na Nakorn on 3/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SemanticTime.h"


@implementation NSDate (SemanticTime)

- (NSString *) semanticIntervalToDate: (NSDate *) date
{
	NSTimeInterval seconds = [date timeIntervalSinceDate:self];
	
	if (seconds <= 0) return @"ขณะนี้";
	
	if (seconds <= 59) return [NSString stringWithFormat:@"%d วินาทีที่แล้ว", (int)seconds];
	
	if (seconds <= ((60 * 60) - 1)) return [NSString stringWithFormat:@"%d นาทีที่แล้ว", (int)(seconds/60)];
	
	if (seconds <= ((60 * 60 * 24) - 1)) return [NSString stringWithFormat:@"%d ชั่วโมงที่แล้ว", (int)(seconds/(60 * 60))];
	
	if (seconds <= ((60 * 60 * 24 * 30) - 1)) return [NSString stringWithFormat:@"%d วันที่แล้ว", (int)(seconds/(60 * 60 * 24))];
	
	if (seconds <= ((60 * 60 * 24 * 365) - 1)) return [NSString stringWithFormat:@"%d เดือนที่แล้ว", (int)(seconds/(60 * 60 * 24 * 30))];
	
	return [NSString stringWithFormat:@"%d ปีที่แล้ว", (int)(seconds/(60 * 60 * 24 * 30 * 365))];
	
}


- (NSString *) semanticIntervalToNow
{
	return [self semanticIntervalToDate:[NSDate date]];
}


- (NSString *) thaiDate
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM yyyy"];
    [formatter setCalendar:cal];
    
    NSLocale *th = [[NSLocale alloc] initWithLocaleIdentifier:@"th"];
    [formatter setLocale:th];
    [th release];

    
    NSString *ret = [formatter stringFromDate:self];
    [formatter release];
    [cal release];
    
    return ret;
}

@end
