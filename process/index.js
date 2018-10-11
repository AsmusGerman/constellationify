var inputImageFile = document.getElementById('imageInput');
var canvas = document.getElementById("canvas");
var canvasContext = canvas.getContext("2d");

inputImageFile.addEventListener('change', (e) => {
    let img = new Image();
    img.onload = function () {
        canvasContext.drawImage(img, 0, 0);
    };
    img.src = URL.createObjectURL(e.target.files[0]);

}, false);

function handleImage(dp = 1, mindist= 45, param1= 75, param2= 40 ){
    let src = cv.imread('canvas');
    let dst = cv.Mat.zeros(src.rows, src.cols, cv.CV_8U);
    let circles = new cv.Mat();
    let color = new cv.Scalar(255, 0, 0);
    cv.cvtColor(src, src, cv.COLOR_RGBA2GRAY, 0);
    // You can try more different parameters
    cv.HoughCircles(src, circles, cv.HOUGH_GRADIENT,
                    1, 45, 75, 40, 0, 0);
    // draw circles
    for (let i = 0; i < circles.cols; ++i) {
        let x = circles.data32F[i * 3];
        let y = circles.data32F[i * 3 + 1];
        let radius = circles.data32F[i * 3 + 2];
        let center = new cv.Point(x, y);
        cv.circle(dst, center, radius, color);
    }
    //cv.imshow('canvasOutput', dst);
    src.delete(); dst.delete(); circles.delete();

}