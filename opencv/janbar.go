package opencv

/*
#include "opencv.h"
*/
import "C"
import (
	"unsafe"
)

//goland:noinspection GoUnusedConst,GoSnakeCaseUsage,SpellCheckingInspection
const (
	CV_TM_SQDIFF        = int(C.CV_TM_SQDIFF)        // 平方差匹配法：该方法采用平方差来进行匹配；最好的匹配值为0；匹配越差，匹配值越大。
	CV_TM_SQDIFF_NORMED = int(C.CV_TM_SQDIFF_NORMED) // 归一化平方差匹配法
	CV_TM_CCORR         = int(C.CV_TM_CCORR)         // 相关匹配法：该方法采用乘法操作；数值越大表明匹配程度越好。
	CV_TM_CCORR_NORMED  = int(C.CV_TM_CCORR_NORMED)  // 归一化相关匹配法
	CV_TM_CCOEFF        = int(C.CV_TM_CCOEFF)        // 相关系数匹配法：1表示完美的匹配；-1表示最差的匹配。
	CV_TM_CCOEFF_NORMED = int(C.CV_TM_CCOEFF_NORMED) // 归一化相关系数匹配法
)

/*MatchTemplate Measures similarity between template and overlapped windows in the source image
  and fills the resultant image with the measurements */
func MatchTemplate(image, temp, result *IplImage, method int) {
	C.cvMatchTemplate(
		unsafe.Pointer(image), unsafe.Pointer(temp), unsafe.Pointer(result),
		C.int(method),
	)
}

/*MinMaxLoc Finds global minimum, maximum and their positions */
func MinMaxLoc(image *IplImage, minVal, maxVal *float64, minLoc, MaxLox *CvPoint, mask *IplImage) {
	C.cvMinMaxLoc(
		unsafe.Pointer(image),
		(*C.double)(unsafe.Pointer(minVal)), (*C.double)(unsafe.Pointer(maxVal)),
		(*C.CvPoint)(unsafe.Pointer(minLoc)), (*C.CvPoint)(unsafe.Pointer(MaxLox)),
		unsafe.Pointer(mask),
	)
}

type CvConnectedComp C.CvConnectedComp

/*FloodFill Fills the connected component until the color difference gets large enough */
func FloodFill(image *IplImage, seedPoint CvPoint, newVal, loDiff, upDiff Scalar, comp *CvConnectedComp, flags int, mask *IplImage) {
	C.cvFloodFill(
		unsafe.Pointer(image),
		C.CvPoint(seedPoint),
		C.CvScalar(newVal), C.CvScalar(loDiff), C.CvScalar(upDiff),
		(*C.CvConnectedComp)(unsafe.Pointer(comp)),
		C.int(flags),
		unsafe.Pointer(mask),
	)
}

type ScalarRGBA int

//goland:noinspection GoUnusedConst
const (
	ScalarB ScalarRGBA = 0
	ScalarG ScalarRGBA = 1
	ScalarR ScalarRGBA = 2
	ScalarA ScalarRGBA = 3
)

/*Get2DIndex return one data */
func (img *IplImage) Get2DIndex(x, y int, i ScalarRGBA) float64 {
	ret := C.cvGet2D(unsafe.Pointer(img), C.int(y), C.int(x))
	return float64(ret.val[C.int(i)])
}
