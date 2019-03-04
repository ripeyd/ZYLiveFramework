//
//  ZYLiveStreamInputView.m
//  ZYLiveFramework
//
//  Created by gao feng on 16/7/27.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamInputView.h"
#import "ZYLiveStreamTextView.h"
#import "ZYLiveStreamBulletSwitch.h"
#import "UIColor+App.h"
#import "UIColor+Hex.h"
#import "UIImageEX.h"

#define kInputViewTextHeight 20

@interface ZYLiveStreamInputView () <UITextFieldDelegate, KCLiveStreamBulletSwitchDelegate>

@property (nonatomic, strong) ZYLiveStreamBulletSwitch *switchBullet;
@property (nonatomic, strong) ZYLiveStreamTextView *inputTextView;
@property (nonatomic, strong) UIView *inputTextViewHolder;
@property (nonatomic, strong) UIButton *btnSend;

@property (nonatomic, assign) int                 initialInputWidth;
@property (nonatomic, assign) int                 totalLimit;


//为了切换输入法时 计算textview的位置与大小
@property (nonatomic, assign) CGRect btnEmojiRect;
@property (nonatomic, strong) UIView *btnSendContainer;
@property (nonatomic, assign) CGFloat textViewHeight;

@end

#define MAXLEN_BULLET_ON  80
#define MAXLEN_BULLET_OFF 150

@implementation ZYLiveStreamInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    
        _totalLimit = MAXLEN_BULLET_OFF;
    }
    return self;
}

- (void)buildInputView
{
    //switchBullet
    int leftPadding = 5;
    int width = 68;
    
    _textViewHeight = 36;
    self.switchBullet = [[ZYLiveStreamBulletSwitch alloc] initWithFrame:CGRectMake(leftPadding, (self.bounds.size.height - _textViewHeight)/2, width, _textViewHeight)];
    [_switchBullet buildViews];
    _switchBullet.switchDelegate = self;
    [self addSubview:_switchBullet];
    
    self.inputTextViewHolder = [UIView new];
    [self addSubview:_inputTextViewHolder];
    _inputTextViewHolder.layer.cornerRadius = 4;
    _inputTextViewHolder.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.42];
    _inputTextViewHolder.clipsToBounds = true;
    
    self.inputTextView = [[ZYLiveStreamTextView alloc] init];
    self.inputTextView.keyboardType = UIKeyboardTypeDefault;
    self.inputTextView.font = [UIFont systemFontOfSize:14];
    self.inputTextView.returnKeyType = UIReturnKeySend;
    self.inputTextView.enablesReturnKeyAutomatically = YES;
    self.inputTextView.contentMode = UIViewContentModeRedraw;
    self.inputTextView.backgroundColor = [UIColor clearColor];
    self.inputTextView.delegate = self;
    _inputTextView.tintColor = [UIColor colorWithHex:0xFFFFFF alpha:0.7];
    _inputTextView.textColor = [UIColor whiteColor];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5]};
    _inputTextView.attributedPlaceholder = [[NSAttributedString alloc]
                                            initWithString:@"" attributes:dic];
    [_inputTextView addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [_inputTextViewHolder addSubview:self.inputTextView];
    
    //btnSend
    _btnSendContainer = [UIView new];
    _btnSendContainer.backgroundColor = [UIColor clearColor];
    _btnSendContainer.clipsToBounds = YES;
    [self addSubview:_btnSendContainer];
    
    int radius = 4;
    self.btnSend = [UIButton new];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor themeSubColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [_btnSend setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE16E78] size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    
    [_btnSend addTarget:self action:@selector(buttonSendClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSend.titleLabel.font = [UIFont systemFontOfSize:14];
    _btnSend.layer.cornerRadius = radius;
    _btnSend.layer.masksToBounds = YES;
    [_btnSendContainer addSubview:_btnSend];
    width = 58;
    
    int rightPadding = 5;
    int originX = self.bounds.size.width - width;
    _btnSendContainer.frame = CGRectMake(self.bounds.size.width - rightPadding - width, (self.bounds.size.height - _textViewHeight)/2, width, _textViewHeight);
    _btnSend.frame = CGRectMake(-radius, 0, width+radius, _textViewHeight);
   
    
    leftPadding = 10;
    originX = CGRectGetMinX(_btnSendContainer.frame) - leftPadding;
    
    leftPadding = 5;
    originX = CGRectGetMaxX(_switchBullet.frame) + leftPadding;
    width = CGRectGetMinX(_btnSendContainer.frame) - originX + radius;
    
    _inputTextViewHolder.frame = CGRectMake(originX, (self.bounds.size.height - _textViewHeight)/2, width, _textViewHeight);
    
    _initialInputWidth = SCREEN_WIDTH - CGRectGetMinX(_btnSend.frame) - originX - 70;
    
    _inputTextView.frame = CGRectMake(0, 1, _initialInputWidth, _textViewHeight);
    
    [self adjustPlaceholder];
}

- (void)didClickBulletSwitch {
    
}


- (void)buttonSendClicked:(id)sender
{
    [self updateInputCount:_inputTextView];
    NSString* content = _inputTextView.text;
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    BOOL useBullets = _switchBullet.isSelected;
    
    _inputTextView.text = @"";
    [self limitTextViewContentDisplay];
}

- (void)clearInputText
{
    _inputTextView.text = @"";
}

- (void)setInpuText:(NSString*)text {
    _inputTextView.text = text;
}

- (NSString *)getInputText
{
    return _inputTextView.text;
}

#pragma  mark - TouchTextFieldDelegate
- (void)didTouchsTextField {
    
}

- (void)buttonEmojiClicked:(id)sender
{
    
}

- (void)detectEmojiClicked:(NSNotification *)notif
{
   
}

- (void)detectEmojiDeleted:(NSNotification *)notif {
    [_inputTextView deleteBackward];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(_switchBullet.frame, point)) {
        return _switchBullet;
    }
    else if (CGRectContainsPoint(_btnSend.superview.frame,point))
    {
        return _btnSend;
    }
    return [super hitTest:point withEvent:event];
}

- (void)refreshUIByKeyboardType:(int)keyboard
{
    
}

- (BOOL)isInputViewTriggeringKeyboard {
    return _inputTextView.isFirstResponder;
}

- (BOOL)isDynamicResign {
    //    return _inputTextView.forceDynamicContentOffset;
    return true;
}

- (void)adjustInputViewOnKeyboardHide {
    //    _inputTextView.forceDynamicContentOffset = false;
}

- (void)adjustInputViewOnKeyboardShow {
    //    _inputTextView.forceDynamicContentOffset = false;
}

- (void)resignTextInputView {
    //    [_inputTextView dynamicResignFirstResponder];
    [_inputTextView resignFirstResponder];
}

- (void)activateTextInputView {
    [self enableInputView:true];
    [_inputTextView becomeFirstResponder];
}

- (void)enableInputView:(BOOL)enable {
    _inputTextView.enabled = enable;
}

#pragma mark- Detect Events
- (void)detectHideStreamKeyboard
{
    [_inputTextView resignFirstResponder];
}

#pragma mark- UITextViewDelegate
- (void)limitTextViewContentDisplay
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self limitTextViewContentDisplay];
    
    [self updateInputCount:textField];
}

//主要 解决粘贴截断问题
-(void)textFieldEditChanged:(UITextField *)textField {
    [self updateInputCount:textField];
    [self adjustPlaceholder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChangeText = YES;
    
    if ([string isEqualToString:@"\n"]) {
        
        [self buttonSendClicked:nil];
        return NO;
    }
  
    return shouldChangeText;
}

- (void)adjustPlaceholder {

}

- (void)updateInputCount:(UITextField*)textView
{

}

- (void)dealloc
{
    [Notif removeObserver:self];
    [_inputTextView removeTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

@end
