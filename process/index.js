var inputImageFile = document.getElementById('imageInput');
var canvas = document.getElementById("canvas");
var canvasContext = canvas.getContext("2d");

inputImageFile.addEventListener('change', (e) => {
    let img = new Image();
    img.onload = function () {
        canvasContext.drawImage(img, 0, 0);
        handleImage();
    };
    img.src = URL.createObjectURL(e.target.files[0]);

}, false);

function handleImage(){
    console.log("nothing here...");
}