//
//  HLLTimeZoneCell.m
//  HLLDemo-00
//
//  Created by Youngrocky on 16/3/19.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLTimeZoneCell.h"
#import "HLLTimeZone.h"

@implementation HLLTimeZoneCell

+ (UINib *) nib{

    return [UINib nibWithNibName:@"HLLTimeZoneCell" bundle:nil];
}

- (void) configureTimeZoneCellWithTimeZone:(HLLTimeZone *)timeZone{

    
    /*
     Cache the formatter. Normally you would use one of the date formatter styles (such as NSDateFormatterShortStyle), but here we want a specific format that excludes seconds.
     */
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"h:mm a" options:0 locale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
    }
    
    self.timeZoneLabel.text = timeZone.localeName;
    
    // Set the time.
    [dateFormatter setTimeZone:timeZone.timeZone];
    self.timeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    // Set the image.
//    self.timeImageView.image = timeZone.image;
}

@end
