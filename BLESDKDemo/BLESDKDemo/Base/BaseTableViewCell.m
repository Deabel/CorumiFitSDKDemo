//
//  BaseTableViewCell.m
//  BLESDKDemo
//
//  Created by Deabel on 2021/7/14.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.secondarySystemBackgroundColor;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

+ (NSString *)reusedIdentifier {
    return NSStringFromClass(self.class);
}
@end
