//
//  LMComposeViewController.m
//  李明微博
//
//  Created by tarena on 16/1/17.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMComposeViewController.h"
#import "LMComposeView.h"
#import "LMComposeToolBar.h"
#import "LMComposePhotosView.h"
#import "LMComposeTool.h"
#import "MBProgressHUD+MJ.h"

@interface LMComposeViewController ()<UITextViewDelegate,LMComposeToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) LMComposeView *composeView;
@property (nonatomic, weak) LMComposeToolBar *toolBar;
@property (nonatomic, weak) LMComposePhotosView *photosView;
//模型赋值给rightBarButtonItem 所以用strong
@property (nonatomic, strong) UIBarButtonItem  *rightBarButton;

@property (nonatomic,strong) NSMutableArray *images;

@end

@implementation LMComposeViewController

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条
    [self setUpNavigationBar];
    
    //添加textView
    [self setUpTextView];
    
    //添加发送工具条
    [self setUpSendToolBar];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //添加相册视图
    [self setUpPhotosView];
}

#pragma mark - UIImgePickerController协议方法 选择图片完成时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //获取选中的图片
    _photosView.selectedImage = image;
    _rightBarButton.enabled = YES;
    [self.images addObject:image];
    [self dismiss];
}

- (void)setUpPhotosView {
    LMComposePhotosView *photosView = [[LMComposePhotosView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height - 100)];
    [_composeView addSubview:photosView];
    _photosView = photosView;
}

#pragma mark - 点击工具条按钮后调用
- (void)composeToolBar:(LMComposeToolBar *)toolBar DidClickButton:(NSInteger)index {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];


    switch (index) {
        case 0:
            [self presentViewController:imagePicker animated:YES completion:nil];
            //相册类型 相册集
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            imagePicker.delegate = self;
            break;
            
        default:
            break;
    }
}

#pragma mark - 键盘的frame改变时调用
- (void)keyBoardFrameChange:(NSNotification *)note {
    //获取动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    //获取键盘frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) {//没有弹出 键盘
        [UIView animateWithDuration:duration animations:^{
            //工具条还原
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    }else {
        [UIView animateWithDuration:duration animations:^{
            //工具条向上移动键盘高度
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

- (void)setUpSendToolBar {
    
    CGFloat x = 0;
    CGFloat w = self.view.width;
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    
    LMComposeToolBar *toolBar = [[LMComposeToolBar alloc]initWithFrame:CGRectMake(x, y, w, h)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
}

- (void)setUpTextView {
    LMComposeView *composeView = [[LMComposeView alloc]initWithFrame:self.view.bounds];
    _composeView = composeView;
    //先设置字体，在设置占位符
    composeView.font = [UIFont systemFontOfSize:18];
    
    //设置占位符
    composeView.placeHolder = @"分享新鲜事...";
    [self.view addSubview:composeView];
    //默认允许垂直方向拖拽 scrollView的属性
    composeView.alwaysBounceVertical = YES;
    
    //监听文本框的输入
    //Observer:谁需要监听通知
    //name:监听的通知的名称
    //object:监听谁发送的通知 nil:表示谁发送都监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    //监听拖拽
    _composeView.delegate = self;
}
#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //拖拽回收键盘
    [_composeView resignFirstResponder];
}
#pragma mark - 文字改变时调用
- (void)textChange {
    //判断下textView有没有内容
    if (_composeView.text.length) {//有内容
        _composeView.hidePlaceHolder = YES;
        _rightBarButton.enabled = YES;
    }else {
        _composeView.hidePlaceHolder = NO;
        _rightBarButton.enabled = NO;
    }
}

//界面弹出的同时弹出键盘
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.composeView becomeFirstResponder];
}

//销毁时移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNavigationBar {
    self.title = @"发微博";
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    //right
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"发送" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    //custom的按钮是没有frame的
    [rightButton sizeToFit];
    //监听按钮点击
    [rightButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _rightBarButton = rightItem;
}
//返回主界面
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发送微博
- (void)send {
    
    if (self.images.count) {
        //发送图片
        [self sendImage];
    }else {
        //发送文字
        [self sendTitle];
    }

}

- (void)sendImage {
    NSString *status = self.composeView.text.length?self.composeView.text : @"分享图片";
    _rightBarButton.enabled = NO;
    [LMComposeTool composeWithImage:self.images[0] status:status success:^{
        //提示用户发送图片成功
        [MBProgressHUD showSuccess:@"发送图片成功"];
        //返回首页
        [self dismiss];
        _rightBarButton.enabled = YES;
    } failure:^(NSError *error) {
        //提示用户发送图片成功
        [MBProgressHUD showSuccess:@"发送图片失败"];
        _rightBarButton.enabled = YES;
    }];
}

- (void)sendTitle {
    //发送文字
    _rightBarButton.enabled = NO;
    [LMComposeTool composeWithStatus:_composeView.text success:^{
        //提示用户发送成功
        [MBProgressHUD showSuccess:@"微博发表成功"];
        //回到首页
        [self dismiss];
        _rightBarButton.enabled = YES;
    } failure:^(NSError *error) {
        //提示用户发送失败
        [MBProgressHUD showSuccess:@"微博发表失败"];
        _rightBarButton.enabled = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
