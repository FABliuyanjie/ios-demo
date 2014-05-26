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
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(flushUI) name:kReflushUserInfo object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
    self.headImage.image = user.photo;
    self.headImage.layer.cornerRadius = 60;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.layer.borderWidth = 3.f;
    self.userNameLb.text = user.nickName;
    [self.phoneNumberBtn setTitle:[NSString stringWithFormat:@"手机号码:%@",user.manPhone] forState:UIControlStateNormal];
    [self.emailBtn setTitle:[NSString stringWithFormat:@"邮箱:%@",user.manEmail?user.manEmail:@"           "] forState:UIControlStateNormal];}


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
    UIImage *image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //如果是刚拍的，保存到相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    User *user = [User readUserInfo];
    NSString *token = user.token;
    [TOOL uploadUserPhoto:image completionHandler:^(bool status, NSString *info) {
        

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(status? @"上传成功":@"上传失败") message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert setBackgroundColor:[UIColor grayColor]];
        
        [alert setContentMode:UIViewContentModeScaleAspectFit];
        
        [alert show];
        
        
        [self  performSelector:@selector(hidenAlter:) withObject:alert afterDelay:2];
        
        if (status) {
            user.photo = image;
            [User saveUserInfo];
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


@end
