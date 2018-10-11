var canvas = document.getElementById("canvas");
var context = canvas.getContext("2d");

var star = {
    size: 5,
    color: "#000000"
};

canvas.addEventListener('click', function () {
    var rect = canvas.getBoundingClientRect();
    var x = event.clientX - rect.left;
    var y = event.clientY - rect.top;

    context.fillStyle = star.color;
    context.beginPath();
    context.arc(x, y, star.size, 0, Math.PI * 2, true);
    context.fill();
});

var superstar = document.getElementById("superstar");
superstar.addEventListener('click', function () {
    star.size = 10;
});

var star = document.getElementById("star");
star.addEventListener('click', function () {
    star.size = 5;
});

var restart = document.getElementById("restart");
restart.addEventListener('click', function () {
    context.clearRect(0, 0, canvas.width, canvas.height);
});

var download = document.getElementById("download");
download.addEventListener('click', function () {
    var image = canvas.toDataURL("image/png;base64;");
    var link = document.createElement('a');
    link.download = "my-image.png";
    link.href = image;
    link.click();
});

var modal = document.getElementById("modal");
var help = document.getElementById("help");
var close = document.getElementById("close");

help.addEventListener('click', function () {
    modal.style.display = "flex";
});

close.addEventListener('click', function () {
    modal.style.display = "none";
});

window.addEventListener('click', function () {
    if (event.target == modal) {
        modal.style.display = "none";
    }
});