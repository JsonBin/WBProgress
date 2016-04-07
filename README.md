# WBProgress

OC编写的一款 进度指示器  当前完成的进度  可自定义颜色设置

#初始化方法 
==========

     // 调用
    self.proview = [[WBProgressView alloc] initWithFrame:CGRectMake(0, 0, 80, 80) progress:0.8 lineWidth:5.0 topColor:[UIColor redColor] bottomColor:[UIColor greenColor]];
    // 显示
    [self.proview showProgressViewInView:self.view];
    
#效果图
==========
![gif](https://github.com/JsonBin/WBProgress/raw/master/WBProgress/progress.gif "效果图")    
