//
//  ViewController.m
//  iOS手势测试
//
//  Created by 翟旭博 on 2022/11/17.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.testView = [[UIView alloc] init];
    self.testView.frame = CGRectMake(10, 10, 200, 200);
    self.testView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.testView];
    
    //创建手势对象(轻点）
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    //设置相关属性
    //点击次数（默认1）
    tap.numberOfTapsRequired = 1;
    //手指的个数（默认1）
    tap.numberOfTouchesRequired = 1;
    //添加到视图
    [self.testView addGestureRecognizer:tap];
    
    
    //创建手势对象（长按）
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    //设置相关属性
    //用几个手指触屏，默认1
    longPressGesture.numberOfTouchesRequired = 1;
    //设置最短长按时间，单位为秒（默认0.5）
    longPressGesture.minimumPressDuration = 1;
    //设置手势识别期间所允许的手势可移动范围
    longPressGesture.allowableMovement = 10;
    //添加到视图
    [self.testView addGestureRecognizer:longPressGesture];

    //创建手势对象（左扫）
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureClick:)];
    //设置轻扫的方向
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    //添加到视图
    [self.testView addGestureRecognizer:leftSwipe];
    //右扫
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureClick:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.testView addGestureRecognizer:rightSwipe];

    //创建手势对象(平移)
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureClick:)];
    //添加到视图
    [self.testView addGestureRecognizer:panGesture];

    //创建手势对象(捏合)
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pichGestureClick:)];
    //添加到视图
    [self.testView addGestureRecognizer:pinchGesture];

    //创建手势对象（旋转）
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureClick:)];
    //添加到视图
    [self.testView addGestureRecognizer:rotationGesture];


}
//点按
- (void)tapClick:(UITapGestureRecognizer *)tap {
    NSLog(@"轻点手势响应！");
    self.view.backgroundColor = [UIColor systemPinkColor];
}

//长按
- (void)longPressClick:(UILongPressGestureRecognizer *)press {
    //state属性是所有手势父类提供的方法，用于记录手势的状态
    if (press.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按手势开始响应!");
    } else if (press.state == UIGestureRecognizerStateChanged) {
        NSLog(@"长按手势状态发生改变!");
    } else {
        NSLog(@"长按手势结束!");
    }
}

//轻扫
-(void)swipeGestureClick:(UISwipeGestureRecognizer *)swpie{
    //如果是左扫
    if (swpie.direction == UISwipeGestureRecognizerDirectionLeft ) {
        self.view.backgroundColor = [UIColor blueColor];
        NSLog(@"左扫!");
    } else {
        self.view.backgroundColor = [UIColor grayColor];
        NSLog(@"右扫!");
    }
}

//平移
- (void)panGestureClick:(UIPanGestureRecognizer *)pan {
    NSLog(@"响应！！");
    //通过pan手势，能够获取到pan.view在self.view上的偏移量
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"x=%.2lf y=%.2lf",point.x,point.y);
    //改变中心点坐标（原来的中心点+偏移量=当前的中心点）
    CGPoint newCenter = CGPointMake(pan.view.center.x + point.x, pan.view.center.y + point.y);
    //CGPointZero<==>CGPointMake(0,0)
    
    //限制拖动范围
    newCenter.y = MAX(pan.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.view.frame.size.height - pan.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(pan.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.view.frame.size.width - pan.view.frame.size.width/2, newCenter.x);
    pan.view.center = newCenter;
    
    //每次调用之后，需要重置手势的偏移量，否则偏移量会自动累加
    [pan setTranslation:CGPointZero inView:self.view];
}

//捏合
- (void)pichGestureClick:(UIPinchGestureRecognizer *)pinch {
    //缩放的系数
    NSLog(@"%.2lf", pinch.scale);
    //固定写法
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    //重置缩放系数（否则系数会累加）
    pinch.scale = 1.0;
}

//旋转
- (void)rotationGestureClick:(UIRotationGestureRecognizer *)rotation {
    //rotation.rotation 手势旋转的角度
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    //重置角度
    rotation.rotation = 20;
}


@end
