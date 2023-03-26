
REM 编译过程中有些下载文件需要代理
set http_proxy=127.0.0.1:1081
set https_proxy=127.0.0.1:1081

IF NOT EXIST "mingw64" (
    REM https://sourceforge.net/projects/mingw-w64/files/
    REM 到这里下载 x86_64-posix-seh ,改名为 mingw64.7z
    7za x -t7z mingw64.7z
)

IF NOT EXIST "cmake" (
    REM https://cmake.org/download/
    REM 到这里下载 cmake-x.x.x-windows-x86_64.zip ,改名为 cmake.zip
    7za x -tzip cmake.zip
    DIR /B "cmake-*" >t.txt
    SET /p cmake_dir=<t.txt
    REN %cmake_dir% cmake
    DEL /Q t.txt
)

IF NOT EXIST "opencv-4.7.0" (
    REM https://github.com/opencv/opencv/archive/4.7.0.zip
    REM 改名为 opencv-4.7.0.zip
    7za x -tzip opencv-4.7.0.zip
)

IF NOT EXIST "opencv_contrib-4.7.0" (
    REM https://github.com/opencv/opencv_contrib/archive/4.7.0.zip
    REM 改名为 opencv_contrib-4.7.0.zip
    7za x -tzip opencv_contrib-4.7.0.zip
)

SET "pwd=%cd%"
IF EXIST "C:\opencv" (
  RD /Q /S C:\opencv
)
REM 重新创建C盘的软连接
mklink /j C:\opencv "%pwd%"

IF NOT EXIST "C:\opencv\build" (
    MD "C:\opencv\build"
)
cd /d "C:\opencv\build"

SET "OLD_PATH=%PATH%"
SET "PATH=C:\opencv\mingw64\bin;C:\opencv\cmake\bin"

set enable_shared=ON
cmake C:\opencv\opencv-4.7.0 -G "MinGW Makefiles" -BC:\opencv\build -DENABLE_CXX11=ON -DOPENCV_EXTRA_MODULES_PATH=C:\opencv\opencv_contrib-4.7.0\modules -DBUILD_SHARED_LIBS=%enable_shared% -DWITH_IPP=OFF -DWITH_MSMF=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_opencv_java=OFF -DBUILD_opencv_python=OFF -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DBUILD_DOCS=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_opencv_saliency=OFF -DBUILD_opencv_wechat_qrcode=ON -DCPU_DISPATCH= -DOPENCV_GENERATE_PKGCONFIG=ON -DWITH_OPENCL_D3D11_NV=OFF -DOPENCV_ALLOCATOR_STATS_COUNTER_TYPE=int64_t -Wno-dev
mingw32-make -j%NUMBER_OF_PROCESSORS%
mingw32-make install

set enable_shared=OFF
cmake C:\opencv\opencv-4.7.0 -G "MinGW Makefiles" -BC:\opencv\build -DENABLE_CXX11=ON -DOPENCV_EXTRA_MODULES_PATH=C:\opencv\opencv_contrib-4.7.0\modules -DBUILD_SHARED_LIBS=%enable_shared% -DWITH_IPP=OFF -DWITH_MSMF=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_opencv_java=OFF -DBUILD_opencv_python=OFF -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DBUILD_DOCS=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_opencv_saliency=OFF -DBUILD_opencv_wechat_qrcode=ON -DCPU_DISPATCH= -DOPENCV_GENERATE_PKGCONFIG=ON -DWITH_OPENCL_D3D11_NV=OFF -DOPENCV_ALLOCATOR_STATS_COUNTER_TYPE=int64_t -Wno-dev
mingw32-make -j%NUMBER_OF_PROCESSORS%
mingw32-make install

SET "PATH=%OLD_PATH%"
IF NOT EXIST "c:\opencv\opencv\build" (
    md "c:\opencv\opencv\build"
)
mklink /j c:\opencv\opencv\build\install c:\opencv\build\install

REM 极限压缩对应目录
7za a -mx9 opencv.7z C:\opencv\opencv
