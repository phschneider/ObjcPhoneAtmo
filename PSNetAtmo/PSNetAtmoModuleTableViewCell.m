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

#define LABEL_WIDTH_TEMP        200
#define LABEL_WIDTH_HUMIDITY    80
#define LABEL_WIDTH_PRESSURE    100
#define LABEL_WIDTH_CO2         80


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

@property (nonatomic) UITapGestureRecognizer *tpgr;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger len;
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
//        self.nameLabel.backgroundColor = [UIColor whiteColor];
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
        self.humidityLabel.textAlignment = NSTextAlignmentLeft;
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
        self.pressureLabel.textAlignment = NSTextAlignmentLeft;
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
        self.co2Label.lineBreakMode = NSLineBreakByClipping;
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

        frame = self.bounds;
        frame.size.height = ceil(self.bounds.size.height / 2);
        frame.size.width = LABEL_WIDTH_PRESSURE;
        frame.origin.x = self.humidityLabel.frame.origin.x + self.humidityLabel.frame.size.width;
        frame.origin.y = frame.size.height;
        
        self.noiseLabel = [self defaultLabelWithText:@"100"];
        self.noiseLabel.autoresizingMask = UIViewAutoresizingNone;
        self.noiseLabel.frame = frame;
        self.noiseLabel.textAlignment = NSTextAlignmentRight;
        self.noiseLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        [self.contentView addSubview:self.noiseLabel];
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
    label.backgroundColor = [UIColor randomColor];
//    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void) layoutSubviews
{
    DLogFuncName();
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 4);
    frame.origin.x = 8;
    frame.origin.y = 5;
    frame.size.width = self.bounds.size.width;
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
    frame.origin.x = 8;
    frame.origin.y = frame.size.height;

    self.humidityLabel.frame = frame;
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 2);
    frame.size.width = LABEL_WIDTH_PRESSURE;
    frame.origin.x = self.humidityLabel.frame.origin.x;
    frame.origin.y = self.humidityLabel.frame.origin.y - ceil (frame.size.height/2);

    self.pressureLabel.frame = frame;
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 2);
    frame.size.width = LABEL_WIDTH_CO2;
    frame.origin.x = self.humidityLabel.frame.origin.x + self.humidityLabel.frame.size.width;
    frame.origin.y = frame.size.height;
    
    self.co2Label.frame = frame;
    
    frame = self.bounds;
    frame.size.height = ceil(self.bounds.size.height / 4);
    frame.size.width =  ceil(self.bounds.size.width / 2);
    frame.origin.x = self.nameLabel.frame.origin.x;
    frame.origin.y = self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height - 10;
    self.dateLabel.frame = frame;
    
    
    frame = self.bounds;
    frame.size.width = LABEL_WIDTH_TEMP;
    frame.origin.y = self.dateLabel.frame.origin.y + 5;
    frame.size.height = self.bounds.size.height - self.dateLabel.frame.origin.y;
    frame.origin.x = self.bounds.size.width - frame.size.width - 5;
    self.tempLabel.frame = frame;
    
    
    frame = self.bounds;
    frame.size.width = LABEL_WIDTH_CO2;
    frame.origin.y = self.pressureLabel.frame.origin.y;
    frame.size.height = self.pressureLabel.frame.size.height;
    frame.origin.x = self.co2Label.frame.origin.x;
    self.noiseLabel.frame = frame;
    
    // Change labels with pressure
//    [self moveRightLabel:self.co2Label toLeftLabel:self.pressureLabel];
//    [self moveTopLabel:self.co2Label toBottomLabel:self.humidityLabel];
//    [self moveTopLabel:self.noiseLabel toBottomLabel:self.pressureLabel];
    
    for (UIView *view in self.contentView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            view.backgroundColor = [UIColor clearColor];
        }
    }
    
//    self.nameLabel.backgroundColor = [UIColor redColor];
}


- (void) moveRightLabel:(UILabel*)rightLabel toLeftLabel:(UILabel*)leftLabel
{
    DLogFuncName();
    
    CGRect rframe = rightLabel.frame;
    CGRect lframe = leftLabel.frame;
//    lframe.size.width = 200;
//    rframe.size.width = 200;
    rightLabel.frame = lframe;
    leftLabel.frame = rframe;
    leftLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.textAlignment = NSTextAlignmentLeft;
}


- (void) moveTopLabel:(UILabel*)topLabel toBottomLabel:(UILabel*)bottomLabel
{
    DLogFuncName();
    CGRect frame = topLabel.frame;
    topLabel.frame = bottomLabel.frame;
    bottomLabel.frame = frame;
}


#pragma mark - PSNetAtmoModule
- (void) setDeviceModule:(PSNetAtmoModule *)deviceModule
{
    DLogFuncName();
   
    PSNetAtmoModuleMeasure *measure = [deviceModule lastMeasure];
   
    DEBUG_CORE_DATA_Log(@"Meassure = %@",measure);
    self.nameLabel.text = deviceModule.name;
//    [self resizeLabelsWith:self.nameLabel];
    self.tempLabel.text = [measure formattedTemperature];
    self.humidityLabel.text = [measure formattedHumidity];
    self.pressureLabel.text = [measure formattedPressure];
    self.co2Label.text = [[measure formattedCo2] stringByReplacingOccurrencesOfString:@"ppm" withString:@""];
    self.dateLabel.text = [measure formattedDateTime];
    self.noiseLabel.text = [measure formattedNoise];
    
    if ([deviceModule deviceTypeIsRainGauge])
    {
        self.tempLabel.text = [measure formattedRain];
    }
    
    self.tpgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnLabel)];
    self.tpgr.numberOfTouchesRequired = 1;
    self.tpgr.numberOfTapsRequired = 1;
    self.co2Label.userInteractionEnabled = YES;
    [self.co2Label addGestureRecognizer:self.tpgr];
}


- (void) tapOnLabel
{
    DLogFuncName();
#warning der timer wird erst nach 2 sekunden angelegt, daher haben wir hier eine race condition ...
    if (self.timer && [self.timer isValid])
    {
        [self.timer invalidate];
        [self stop];
    }
    else
    {
        [self start];
    }
}


- (void) stop
{
    DLogFuncName();
    self.co2Label.text = [self.co2Label.text stringByReplacingOccurrencesOfString:@"ppm" withString:@""];
}


- (void) start
{
    DLogFuncName();

    self.len = self.co2Label.text.length;
    
#warning animate fade in ...
    self.co2Label.text = [self.co2Label.text stringByAppendingString:@"ppm"];

    
    // animate fade out ...
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                      target: self
                                                    selector:@selector(scrollText)
                                                    userInfo: nil
                                                     repeats:YES];

    });
}


- (void) scrollText
{
    if (![self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    NSLog(@"Test = |%@]",self.co2Label.text);
    
    NSInteger len = self.co2Label.text.length;

    
    NSString *myString = [self.co2Label.text substringToIndex:--len];
    

    
    if (len >= self.len) {
        [self.co2Label setText:myString];
        
    }
    if (len == self.len)
    {
        [self.timer invalidate];
    }
}


- (void) resizeLabelsWith:(UILabel *)label
{
    DLogFuncName();
    
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    CGRect frame = label.frame;
    frame.size = size;
    label.frame = frame;
}

@end
