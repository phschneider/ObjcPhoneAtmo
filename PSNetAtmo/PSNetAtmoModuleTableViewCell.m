//
//  PSNetAtmoModuleTableViewCell.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "UIColor+Random.h"
#import "PSNetAtmoModuleTableViewCell.h"

#import "PSNetAtmoModule.h"
#import "PSNetAtmoModule+Helper.h"

#import "PSNetAtmoModuleMeasure.h"
#import "PSNetAtmoModuleMeasure+Helper.h"

#define LABEL_WIDTH_TEMP        130
#define LABEL_WIDTH_HUMIDITY    50
#define LABEL_WIDTH_PRESSURE    60
#define LABEL_WIDTH_CO2         60


@interface PSNetAtmoModuleTableViewCell ()
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *tempLabel;
@property (nonatomic) UILabel *humidityLabel;
@property (nonatomic) UILabel *co2Label;
@property (nonatomic) UILabel *pressureLabel;
@property (nonatomic) UILabel *rainLabel;
@property (nonatomic) UILabel *noiseLabel;
@property (nonatomic) UILabel *wifiLabel;
@property (nonatomic) UILabel *batteryLabel;
@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UIView *line;
@end

@implementation PSNetAtmoModuleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    DLogFuncName();
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect frame = self.bounds;
        frame.size.height = 0.5;
        frame.origin.x = 15;
//        self.line = [[UIView alloc] initWithFrame:frame];
//        self.line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        self.line.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:self.line];
        
        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 2);
        frame.origin.x = 15;
        frame.size.width = self.bounds.size.width - LABEL_WIDTH_TEMP;
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [self defaultLabelWithText:@"name"];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.nameLabel.frame = frame;
        [self.contentView addSubview:self.nameLabel];
        
        frame = self.bounds;
        frame.size.width = LABEL_WIDTH_TEMP;
        frame.origin.x = self.bounds.size.width - frame.size.width;
        
        self.tempLabel = [self defaultLabelWithText:@"5°"];
        self.tempLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        self.tempLabel.frame = frame;
        self.tempLabel.textAlignment = NSTextAlignmentRight;
        self.tempLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:52];
        [self.contentView addSubview:self.tempLabel];
        
        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 2);
        frame.size.width = LABEL_WIDTH_HUMIDITY;
        frame.origin.x = 15;
        frame.origin.y = frame.size.height;
        
        self.humidityLabel = [self defaultLabelWithText:@"5%"];
        self.humidityLabel.frame = frame;
        self.humidityLabel.textAlignment = NSTextAlignmentRight;
        self.humidityLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        [self.contentView addSubview:self.humidityLabel];
        
        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 2);
        frame.size.width = LABEL_WIDTH_PRESSURE;
        frame.origin.x = self.humidityLabel.frame.origin.x + self.humidityLabel.frame.size.width;
        frame.origin.y = frame.size.height;
        
        self.pressureLabel = [self defaultLabelWithText:@"5%"];
        self.pressureLabel.autoresizingMask = UIViewAutoresizingNone;
        self.pressureLabel.frame = frame;
        self.pressureLabel.textAlignment = NSTextAlignmentRight;
        self.pressureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        [self.contentView addSubview:self.pressureLabel];

        
        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 2);
        frame.size.width = LABEL_WIDTH_CO2;
        frame.origin.x = self.pressureLabel.frame.origin.x + self.pressureLabel.frame.size.width;
        frame.origin.y = frame.size.height;
        
        self.co2Label = [self defaultLabelWithText:@"1000"];
        self.co2Label.autoresizingMask = UIViewAutoresizingNone;
        self.co2Label.frame = frame;
        self.co2Label.textAlignment = NSTextAlignmentRight;
        self.co2Label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        [self.contentView addSubview:self.co2Label];

        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 4);
        frame.size.width =  ceil(self.bounds.size.width / 2);
        frame.origin.x = self.nameLabel.frame.origin.x;
        frame.origin.y = self.nameLabel.frame.origin.y +  + self.nameLabel.frame.size.height;
        
        self.dateLabel = [self defaultLabelWithText:@"01.01.1970 14:30"];
        self.dateLabel.autoresizingMask = UIViewAutoresizingNone;
        self.dateLabel.frame = frame;
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        self.dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:10];
        [self.contentView addSubview:self.dateLabel];
//
//        self.nameLabel = [self defaultLabelWithText:@""];
//        self.nameLabel.font = [UIFont boldSystemFontOfSize:22];
//        self.nameLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.nameLabel];
//        
//        self.temparatureLabel = [self defaultLabelWithText:@""];
//        self.temparatureLabel.font = [UIFont boldSystemFontOfSize:100];
//        self.temparatureLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.temparatureLabel];
//        
//        self.humidityLabel = [self defaultLabelWithText:@""];
//        self.humidityLabel.font = [UIFont boldSystemFontOfSize:40];
//        self.humidityLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.humidityLabel];
//        
//        [self bringSubviewToFront:self.nameLabel];
//        [self bringSubviewToFront:self.temparatureLabel];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    DLogFuncName();
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel*)defaultLabelWithText:(NSString*)text
{
    DLogFuncName();
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = text;
    label.textColor = [UIColor blackColor];
//    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(-2,-2);
//    label.backgroundColor = [UIColor randomColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void) layoutSubviews
{
    DLogFuncName();
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 3);
    frame.origin.x = 15;
    frame.size.width = self.bounds.size.width - LABEL_WIDTH_TEMP;
    self.nameLabel.frame = frame;
    
//    CGSize size = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
//    frame = self.nameLabel.frame;
//    frame.size = CGSizeMake(size.width + 15, frame.size.height);
//    self.nameLabel.frame = frame;
//
//    self.line.center = CGPointMake(self.line.center.x, self.nameLabel.center.y);
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 2);
    frame.size.width = LABEL_WIDTH_HUMIDITY;
    frame.origin.x = 15;
    frame.origin.y = frame.size.height;

    self.humidityLabel.frame = frame;
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 2);
    frame.size.width = LABEL_WIDTH_PRESSURE;
    frame.origin.x = self.humidityLabel.frame.origin.x + self.humidityLabel.frame.size.width;
    frame.origin.y = frame.size.height;

    self.pressureLabel.frame = frame;
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 2);
    frame.size.width = LABEL_WIDTH_CO2;
    frame.origin.x = self.pressureLabel.frame.origin.x + self.pressureLabel.frame.size.width;
    frame.origin.y = frame.size.height;
    
    self.co2Label.frame = frame;
    
    frame = self.bounds;
    frame.size.width = LABEL_WIDTH_TEMP;
    frame.origin.x = self.bounds.size.width - frame.size.width - 5;
    self.tempLabel.frame = frame;
    
    
    frame.size.height = ceil(self.bounds.size.height / 4);
    frame.size.width =  ceil(self.bounds.size.width / 2);
    frame.origin.x = self.nameLabel.frame.origin.x;
    frame.origin.y = self.nameLabel.frame.origin.y +  + self.nameLabel.frame.size.height;
    self.dateLabel.frame = frame;
    
//    for (UIView *view in self.contentView.subviews)
//    {
//        if ([view isKindOfClass:[UILabel class]])
//        {
//            view.backgroundColor = [UIColor clearColor];
//        }
//    }
    
//    self.nameLabel.backgroundColor = [UIColor redColor];
}


#pragma mark - PSNetAtmoModule
- (void) setDeviceModule:(PSNetAtmoModule *)deviceModule
{
    DLogFuncName();
   
    PSNetAtmoModuleMeasure *measure = [deviceModule lastMeasure];
    
//    self.nameLabel.text = deviceModule.name;
//    CGSize size = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:self.nameLabel.font}];
//    CGRect frame = self.nameLabel.frame;
//    frame.size = size;
//    self.nameLabel.frame = frame;
    
    self.tempLabel.text = [measure formattedTemperature];
    self.humidityLabel.text = [measure formattedHumidity];
    self.pressureLabel.text = [measure formattedPressure];
    self.co2Label.text = [measure formattedCo2];
    self.dateLabel.text = [measure formattedDateTime];
}


@end
