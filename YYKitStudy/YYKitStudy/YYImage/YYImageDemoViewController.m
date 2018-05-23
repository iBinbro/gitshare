//
//  YYImageDemoViewController.m
//  YYKitStudy
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YYImageDemoViewController.h"

#import <YYImage.h>
#import <YYAnimatedImageView.h>
#import <YYSpriteSheetImage.h>
#import <YYFrameImage.h>

@interface YYImageDemoViewController (){
    YYAnimatedImageView *imageView;
    YYImage *gifImage;
    
    YYAnimatedImageView *spriteImageView;
    YYSpriteSheetImage *yyspriteImage;
    
    YYAnimatedImageView *imageViewFrame;
    YYFrameImage *frameImage;
}

@end

@implementation YYImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupYYImage];
}

//图片动画
//配套简书：https://www.jianshu.com/p/b63f25b0ae2d
- (void)setupYYImage{
    //********************
    //1、显示动画类型gif的图片
    //********************
    gifImage = [YYImage imageNamed:@"yygif.gif"];
    imageView = [[YYAnimatedImageView alloc] initWithImage:gifImage];
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(50, 10, 480*0.3, 270*0.3);
    
    [self.view addSubview:imageView];
    //    imageView.autoPlayAnimatedImage = NO;//关闭自动播放功能
    
    
    //***********
    //2、精灵图动画
    //***********
    UIImage *spriteImage = [UIImage imageNamed:@"sprite.png"];//获取图片
    NSMutableArray *contentRectsAryM = [[NSMutableArray alloc] init];//精灵图每一小张的Rect(大小和位置)
    NSMutableArray *frameAnimationDuration = [[NSMutableArray alloc] init];//与rect数组对应，每一小张对应的动画时间
    NSInteger rowNum = 6.f;//一行上有几小张
    NSInteger colNum = 8.f;//一列上有几小张
    for (NSInteger i=0; i<rowNum; i++) {
        for (NSInteger j=0; j<colNum; j++) {
            CGRect rect = CGRectMake(i*spriteImage.size.width/rowNum, j*spriteImage.size.height/colNum, spriteImage.size.width/rowNum, spriteImage.size.height/colNum);
            NSValue *rectValue = [NSValue valueWithCGRect:rect];
            [contentRectsAryM addObject:rectValue];
            [frameAnimationDuration addObject:@(1/30.f)];//对应动画持续时间
        }
    }
    yyspriteImage = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:spriteImage contentRects:contentRectsAryM frameDurations:frameAnimationDuration loopCount:1];//UIImage转为YYSpriteSheetImage
    
    //    创建视图 加载YYSpriteSheetImage
    spriteImageView = [[YYAnimatedImageView alloc] initWithImage:yyspriteImage];
    spriteImageView.frame = CGRectMake(50, 110, spriteImage.size.width/6.f, spriteImage.size.height/8.f);
    spriteImageView.clipsToBounds = YES;
    [self.view addSubview:spriteImageView];
    //    spriteImageView.autoPlayAnimatedImage = NO;//关闭自动播放功能
    
    
    
    //******************
    //3、帧动画 一次加载图片
    //******************
    NSMutableArray *imagePathsM = [NSMutableArray array];//存有图片路径的数组
    for (int p=0; p<8; p++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d.png", p+1] ofType:nil];
        [imagePathsM addObject:path];
    }
    NSArray *times = @[@0.1, @0.2, @0.1, @0.1, @0.1, @0.1, @0.1, @0.1];//每张图的动画时间
    frameImage = [[YYFrameImage alloc] initWithImagePaths:imagePathsM frameDurations:times loopCount:1];//0为无限循环
    imageViewFrame = [[YYAnimatedImageView alloc] initWithImage:frameImage];
    imageViewFrame.frame = CGRectMake(50, 50, 210, 100);
    [self.view addSubview:imageViewFrame];
    //    imageViewFrame.autoPlayAnimatedImage = NO;//关闭自动播放功能
}

/**
 currentAnimatedImageIndex animatedImageFrameCount.
 
 设置currentAnimatedImageIndex显示指定的图片.
 animatedImageFrameCount动画一共有多少张图，可用来计算进度.
 精灵图动画currentAnimatedImageIndex属性必须在动画执行过程中才会生效，如果动画停止无反应
 */
- (IBAction)playPauseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected){
        //        [imageView stopAnimating];
        //        [imageViewFrame stopAnimating];
        
        imageView.currentAnimatedImageIndex = gifImage.animatedImageFrameCount*0.5;
        imageViewFrame.currentAnimatedImageIndex = frameImage.animatedImageFrameCount*0.5;
        
        spriteImageView.currentAnimatedImageIndex = 1;
    }else{
        //        [imageView startAnimating];
        //        [imageViewFrame startAnimating];
        imageView.currentAnimatedImageIndex = gifImage.animatedImageFrameCount*0.2;
        imageViewFrame.currentAnimatedImageIndex = frameImage.animatedImageFrameCount*0.2;
        
        spriteImageView.currentAnimatedImageIndex = 27;
    }
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
