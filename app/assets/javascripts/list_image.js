// Đặt mỗi cột bằng 1/4 màn hình
var screenWidth = $(window).width();
var divWidth = screenWidth / 4;
$(".fix-picture").width(divWidth);

// Xử lý sử kiện hover
$(".fix-picture")
  .on("mouseenter", function () {
    $(this).find(".create-card").css({
      color: "#007bff",
    });
  })
  .on("mouseleave", function () {
    $(this).find(".create-card").css({
      color: "transparent",
    });
  });
