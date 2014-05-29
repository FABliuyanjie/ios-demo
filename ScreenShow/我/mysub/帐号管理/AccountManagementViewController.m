//
//  AccountManagementViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-3-20.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "AccountManagementViewController.h"
#import "ChangHeadPhotoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APService.h"
#import "SDImageCache.h"



@interface AccountManagementViewController ()
{
    UIImagePickerController *imagePicker;

}
@end

@implementation AccountManagementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320, 580);
    self.title = @"账号管理";
    [self flushUI];
   
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(flushUI) name:kReflushUserInfo object:nil];
//    self.navigationController.navigationBar.translucent  = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//刷新UI
-(void)flushUI
{
    User *user = [User shareUser];
    //TODO: 等级信息设置
    self.level1Image = nil;
    self.level1Lb.text = @"美女主播";
    self.level2Image = nil;
    self.level2Lb.text = @"大富翁";
    
    //设置手机号码和邮箱地址
    [self.headImage setImageWithURL:[NSURL URLWithString:[User shareUser].photoUrl] placeholderImage:[UIImage imageNamed:@"login_headImage"]];
    self.headImage.layer.cornerRadius = 60;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.layer.borderWidth = 5.f;
    self.userNameLb.text = user.nickName;
    NSString *manPhone = [user.manName isEqualToString:@""]?@"未绑定":user.manPhone;
    NSString *manEmail = [user.manPhone isEqualToString:@""]?@"未绑定":user.manEmail;
    [self.phoneNumberBtn setTitle:[NSString stringWithFormat:@"手机号码:%@",manPhone] forState:UIControlStateNormal];
    [self.emailBtn setTitle:[NSString stringWithFormat:@"邮箱:%@",manEmail] forState:UIControlStateNormal];}


#pragma mark - 修改头像
- (IBAction)changHeadPhoto:(UITapGestureRecognizer *)sender {
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"更改头像" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"从手机相册获取",@"现在拍一张", nil];
    [alter show];

    return;
}

//上传头像，通知刷新界面
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //立刻关闭选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.navigationController.navigationBar.translucent  = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    UIImage *image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //如果是刚拍的，保存到相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    [TOOL uploadUserPhoto:image completionHandler:^(bool status, NSString *info) {
//        [[iToast makeText:status?@"上传成功":@"上传失败"]show];
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"确定" message:status?@"上传成功":@"上传失败" delegate:@"" cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
//        [alter dismissWithClickedButtonIndex:0 animated:YES];
        if (status) {
            [User shareUser].photo = image;
            [[User shareUser] saveUserInfo];
            SendNoti(kReflushUserInfo);
        }
    }];
    
}

#pragma mark- 退出
- (IBAction)LogOut:(id)sender {
    LOGOUT;
    [TOOL logOut];
    SendNoti(kLogOutSuccess);
    [APService setAlias:nil callbackSelector:nil object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -- Alert Delegate 选择头像来源，确认解绑
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
        
    if (imagePicker==nil) {
        imagePicker = [[UIImagePickerController alloc] init];
    }
    if (buttonIndex==2) {
        
#if TARGET_IPHONE_SIMULATOR
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"sorry" message:@"模拟器不支持拍照哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
#endif
    }

    switch (buttonIndex) {
        case 1:
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            imagePicker = nil;
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
            return;
            break;
    }
  
    imagePicker.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
  
}

#pragma make - 取消
-(void)hidenAlter:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

//FIXME:
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
}

-(void)viewDidAppear:(BOOL)animated{

    self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (navigationController == imagePicker.navigationController) {
        navigationController.navigationBar.translucent = NO;
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:0.868 alpha:1.000] size:CGSizeMake(320, 44) andRoundSize:0];
        [navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        navigationController.navigationBar.hidden = NO;

//    }
}
@end
