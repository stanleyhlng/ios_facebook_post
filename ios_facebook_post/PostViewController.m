//
//  PostViewController.m
//  ios_facebook_post
//
//  Created by Stanley Ng on 6/5/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postContentImageView;
@property (weak, nonatomic) IBOutlet UIView *postContentContainerView;
@property (weak, nonatomic) IBOutlet UIView *commentContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *tabBarImageView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (IBAction)onTapPostButton:(id)sender;
- (IBAction)onLikeButton:(id)sender;
- (IBAction)onTap:(id)sender;

// Declare some methods that will be called when the keyboard is about to be shown or hidden
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.postContentImageView.layer.masksToBounds = YES;
    self.postContentImageView.layer.cornerRadius = 2;

    self.postContentContainerView.layer.masksToBounds = YES;
    self.postContentContainerView.layer.cornerRadius = 2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapPostButton:(id)sender {
    self.commentTextField.text = @"";
    [self.view endEditing:YES];
}

- (IBAction)onLikeButton:(id)sender {
    NSLog(@"onLikeButton");
    
    [UIView animateWithDuration:1
                     animations:^{
                     }
                     completion:^(BOOL finished) {
                         self.likeButton.selected = !self.likeButton.selected;
                     }
     ];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentContainerView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentContainerView.frame.size.height, self.commentContainerView.frame.size.width, self.commentContainerView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    [self.view endEditing:YES];
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize;
    kbSize.height = self.tabBarImageView.frame.size.height;
    kbSize.width = 0;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentContainerView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentContainerView.frame.size.height, self.commentContainerView.frame.size.width, self.commentContainerView.frame.size.height);
                     }
                     completion:nil];
}

@end
