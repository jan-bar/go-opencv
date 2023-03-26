## 编译opencv

[文档](https://gocv.io/getting-started/windows/)

下载gcc环境: [下载地址](https://sourceforge.net/projects/mingw-w64/files/),选择最新版`x86_64-posix-seh`

下载cmake: [下载地址](https://cmake.org/download/),可以选择zip免安装版本

然后根据脚本进行编译: [编译脚本](https://github.com/hybridgroup/gocv/blob/release/win_build_opencv.cmd)

`set http_proxy=127.0.0.1:1081 & set https_proxy=127.0.0.1:1081` 设置代理中途需要下载GitHub资源

`set enable_shared=ON` 使用动态dll编译,记得cmake命令里面几个路径改为自己需要的

`cp install\x64\mingw\bin C:\opencv\build\install\x64\mingw\lib`,将dll复制到gocv默认路径

`cp install\include C:\opencv\build\install\include`,将dll复制到gocv默认路径

注意编译出来的可执行程序还依赖`libwinpthread-1.dll,libstdc++-6.dll,libgcc_s_seh-1.dll`这3个dll,一般安装window的git就有

不然还得将上面解压的gcc环境里的这3个dll路径添加到PATH环境变量中

参照: [build_opencv](build_opencv.bat)
