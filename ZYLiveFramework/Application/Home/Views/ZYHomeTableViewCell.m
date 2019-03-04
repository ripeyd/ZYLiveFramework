//
//  ZYHomeTableViewCell.m
//  ZYLiveFramework
//
//  Created by ZhuYan on 2018/10/23.
//  Copyright © 2018 ZhuYan. All rights reserved.
//

#import "ZYHomeTableViewCell.h"
#import "ZYChannelProfile.h"

#define avatarWidth         35.0f
#define avatarHeight        35.0f
#define locImgWidth         8.0f
#define locImgHeight        10.0f
#define broImgWidth         11.0f
#define broImgHeight        8.0f
#define horizontalMargin    11.0f
#define verticalMargin      11.0f
#define topViewHeight       54.0f


@interface ZYHomeTableViewCell ()

@property (nonatomic, strong) UIImageView           *imgAvatar;//头像
@property (nonatomic, strong) UILabel               *lbName;//名称
@property (nonatomic, strong) UIImageView           *imgLocation;//位置图像
@property (nonatomic, strong) UILabel               *lbLocation;//位置文字
@property (nonatomic, strong) UILabel               *lbBrowse;//浏览数文字
@property (nonatomic, strong) UIImageView           *imgContent;//内容图片
@property (nonatomic, strong) UILabel               *lbLiveStatus;//直播状态
@property (nonatomic, strong) UILabel               *lbFooter;//底部文字, 是否要用富文本？？？
@property (nonatomic, strong) UILabel               *lbWatching;
@property (nonatomic, strong) UIView                *firstLineView;
@property (nonatomic, strong) UIView                *secondLineView;
@property (nonatomic, strong) ZYChannelProfile      *cellModel;

@end

@implementation ZYHomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //添加头像
        self.imgAvatar = [UIImageView new];
        [self.contentView addSubview:self.imgAvatar];
        
        //添加名称
        self.lbName = [UILabel new];
        self.lbName.backgroundColor = [UIColor clearColor];
        self.lbName.textColor = [UIColor blackColor];
        self.lbName.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.lbName];
        
        //添加位置图像
        self.imgLocation = [UIImageView new];
        [self.contentView addSubview:self.imgLocation];
        
        //添加位置文字
        self.lbLocation = [UILabel new];
        self.lbLocation.backgroundColor = [UIColor clearColor];
        self.lbLocation.textColor = [UIColor grayFontColor];
        self.lbLocation.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:self.lbLocation];
        
        //添加浏览数文字
        self.lbBrowse = [UILabel new];
        self.lbBrowse.backgroundColor = [UIColor clearColor];
        self.lbBrowse.textColor = [UIColor themeSubColor];
        self.lbBrowse.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:self.lbBrowse];
        
        self.lbWatching = [UILabel new];
        self.lbWatching.backgroundColor = [UIColor clearColor];
        self.lbWatching.textColor = [UIColor grayFontColor];
        self.lbWatching.font = [UIFont systemFontOfSize:12.0f];
        self.lbWatching.text = @"正在观看";
        [self.contentView addSubview:self.lbWatching];
        
        //添加内容图片
        self.imgContent = [UIImageView new];
        self.imgContent.contentMode = UIViewContentModeScaleAspectFill;
        self.imgContent.clipsToBounds = YES;
        [self.contentView addSubview:self.imgContent];
        
        //右上角直播状态
        self.lbLiveStatus = [[UILabel alloc] init];
        self.lbLiveStatus.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.10];
        self.lbLiveStatus.font = [UIFont systemFontOfSize:14.0f];
        self.lbLiveStatus.textColor = [UIColor whiteColor];
        self.lbLiveStatus.layer.cornerRadius = 10;
        self.lbLiveStatus.textAlignment = NSTextAlignmentCenter;
        self.lbLiveStatus.layer.borderColor = [UIColor whiteColor].CGColor;
        self.lbLiveStatus.layer.borderWidth = 1.0;
        self.lbLiveStatus.clipsToBounds = YES;
        [self.imgContent addSubview:self.lbLiveStatus];
        
        [self.contentView addSubview:self.firstLineView];
        [self.contentView addSubview:self.secondLineView];
        
        //添加底部文字
        self.lbFooter = [UILabel new];
        self.lbFooter.backgroundColor = [UIColor clearColor];
        self.lbFooter.textColor = [UIColor colorWithHex:0x38393D];
        self.lbFooter.font = [UIFont systemFontOfSize:14.0f];
        self.lbFooter.numberOfLines = 2;
        [self.contentView addSubview:self.lbFooter];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

#pragma mark - 设置数据模型
- (void)setCellContent:(id)model
{
    if (model) {
        self.cellModel = model;
        self.imgAvatar.image = nil;
        self.imgContent.image = nil;
        self.imgAvatar.image = [UIImage imageNamed:@"logic_icon"];
        
        self.lbName.text = self.cellModel.ownerName;
        self.imgLocation.image = [UIImage imageNamed:@"ic_location"];
        self.imgLocation.hidden = NO;
        self.lbLocation.text = self.cellModel.ownerLocation;
        
        if ([self.cellModel.ownerLocation isEqualToString:@""]) {
            self.imgLocation.hidden = YES;
        }
        
        self.lbBrowse.text = [NSString stringWithFormat:@"%d",self.cellModel.userCount.intValue];
        self.lbFooter.text = self.cellModel.title;
        
        self.imgContent.image = [UIImage imageNamed:self.cellModel.ownerCover];
        
        self.lbLiveStatus.text = self.cellModel.liveStatus;
        [self setNeedsLayout];
    }
    
}

#pragma mark -  设置布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    //imgAvatar
    CGRect avatarRect = CGRectMake(horizontalMargin, verticalMargin, avatarWidth, avatarHeight);
    
    CGSize size = [_lbWatching sizeThatFits:CGSizeZero];
    
    CGRect lbWatchingRect = CGRectMake(SCREEN_WIDTH - size.width - 9, (topViewHeight - size.height)/2.0, ceilf(size.width), ceilf(size.height));
    //lbBrowse
    size = [_lbBrowse sizeThatFits:CGSizeZero];
    
    CGRect lbBrowseRect = CGRectMake(CGRectGetMinX(lbWatchingRect) - size.width - 4,(topViewHeight - size.height)/2.0, ceilf(size.width), ceilf(size.height));
    
    //lbName
    size = [_lbName sizeThatFits:CGSizeZero];
    CGFloat nameWidth = MIN(ceilf(size.width), CGRectGetMinX(lbBrowseRect) - avatarWidth - 2 * horizontalMargin);
    
    int nameMarginY = verticalMargin;
    if (_imgLocation.hidden == true) {
        nameMarginY = verticalMargin + (avatarHeight/2-_lbName.frame.size.height/2);
    }
    
    CGRect lbNameRect = CGRectMake(avatarWidth + 2 * horizontalMargin, nameMarginY, nameWidth, avatarHeight/2);
    
    //imgLocation
    CGRect imgLocationRect = CGRectMake(avatarWidth + 2 * horizontalMargin, 31, locImgWidth, locImgHeight);
    
    //lbLocation
    size = [_lbLocation sizeThatFits:CGSizeZero];
    CGRect lbLocationRect = CGRectMake(imgLocationRect.origin.x + locImgWidth + 3 , 29, ceilf(size.width), ceilf(size.height));
    
    
    //imgContent
    CGRect imgContentRect = CGRectMake(0, avatarRect.size.height + 2 * verticalMargin, SCREEN_WIDTH, SCREEN_WIDTH*608/1080);//
    //lbLiveStatus
    size = [_lbLiveStatus sizeThatFits:CGSizeZero];
    
    CGRect lbLiveStatusRect = CGRectMake(SCREEN_WIDTH - size.width - 30, 10, ceilf(size.width) + 20, 20);
    
    _firstLineView.frame = CGRectMake(0, imgContentRect.origin.y , SCREEN_WIDTH, 0.5);
    _secondLineView.frame = CGRectMake(0, imgContentRect.origin.y +SCREEN_WIDTH, SCREEN_WIDTH, 0.5);
    
    //lbFooter
    CGFloat originY = imgContentRect.origin.y + SCREEN_WIDTH*608/1080;
    CGRect lbFooterRect = CGRectMake(horizontalMargin, originY, self.contentView.bounds.size.width - 2 * horizontalMargin, self.contentView.bounds.size.height - originY - 8.0f);
    
    self.imgAvatar.frame = avatarRect;
    self.lbWatching.frame = lbWatchingRect;
    self.lbBrowse.frame = lbBrowseRect;
    self.lbName.frame = lbNameRect;
    self.imgLocation.frame = imgLocationRect;
    self.lbLocation.frame = lbLocationRect;
    self.imgContent.frame = imgContentRect;
    self.lbLiveStatus.frame = lbLiveStatusRect;
    self.lbFooter.frame = lbFooterRect;
    
//    _imgAvatar.layer.cornerRadius = avatarRect.size.width/2;
//    _imgAvatar.layer.masksToBounds = true;
}

- (void)dealloc
{
    [Notif removeObserver:self];
}


@end
