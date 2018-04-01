# DvideoPlay
传送门链接地址：https://github.com/kevindcw/DvideoPlay

播放器横竖屏切换，左右滑动手势快进

<h1> <img src="http://7xpxoc.com1.z0.glb.clouddn.com/%E8%A7%86%E9%A2%91%E5%9B%BE.gif" width="320" /> </h1>
<h2>想要控制横竖屏切换，第一步首先创建一个继承自UINavigationController的类，重写方法</h2>
<h3>
<img src="http://7xpxoc.com1.z0.glb.clouddn.com/DNavigationController%E4%BB%A3%E7%A0%81.png" width="500"  /></h3>
<h4>第二步在UIViewController里加上  - (BOOL)shouldAutorotate{return NO;} </h4>
<h5> DScreenDirectionHorizontal,//横屏 DScreenDirectionVertical,  //竖屏 VerticaTime;//每次快进几秒 更多请看代码</h5>



