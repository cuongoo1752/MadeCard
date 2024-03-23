// Khởi tạo giá trị index của layer
var index = 0;
function AddAndGetIndex() {
  index++;
  $("#index").val(index);
  return index;
}

function getIndex() {
  return index;
}

// Tạo giá trị từ controller
const wish_title = $("#wish_title").val();
const wish_content = $("#wish_content").val();

// Khởi tạo giá trị index đang chọn
const NOT_SELECT = -1;
var currentSelectIndex = NOT_SELECT;
function setCurrentSelectIndex(selectIndex) {
  currentSelectIndex = selectIndex;
}

function getCurrentSelectIndex() {
  return currentSelectIndex;
}

// Xử lý canvas
const imageInput = $("#imageInput");

var img = $("<img/>");
img.on("load", function () {
  var canvas = $("<canvas/>")[0];
  canvas.width = this.width;
  canvas.height = this.height;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(this, 0, 0);

  $(".canvas-board").append(canvas);
  $("canvas").attr("id", "designCanvas");
  $(".canvas-board").css("width", this.width).css("height", this.height);
});

function nameLayer(layerType, indexLayer) {
  return `layer_${layerType}_${indexLayer}`;
}

img.attr("src", $("#imageInput").attr("src"));

function addLayerText(type, content = "") {
  // Tạo layer ở phần các lớp
  let indexLayer = AddAndGetIndex();
  let $newLayer = $(`.layer-template-${type}`)
    .clone()
    .removeClass(`layer-template-${type}`)
    .removeAttr("style")
    .attr("index", indexLayer);
  $(".layers").append($newLayer);

  // Đổi content nếu có
  let $inputText = $(`.layer[index=${indexLayer}] .text`);
  $inputText.val(content);

  // Thêm name có index để đánh dấu
  $inputText.attr("name", nameLayer(type, indexLayer));

  // Tạo detail của text
  if (type == "text" || type == "textLong") {
    let $newDetailLayer = $(".detail-template")
      .clone()
      .removeClass("detail-template")
      .attr("index", indexLayer);
    $(".row-board").append($newDetailLayer);
  }
}

// Xóa layer cuối
$("#deleteLastLayer").click(function (event) {
  event.preventDefault();
  $(".layers li:last-child").remove();
});

// Tạo layer text ngắn
$("#addText").click(function (event) {
  event.preventDefault();
  addLayerText("text");
});

// Tạo layer text dài
$("#addLongText").click(function (event) {
  event.preventDefault();
  addLayerText("textLong");
});

// Xóa layer
$(".layers").on("click", ".delete-layer", function () {
  $(this).closest(".layer").remove();
});

// Khi click và layer
$(".layers").on("click", ".layer", function () {
  // Hiển thị UI layer
  $(".layer").removeClass("layer-select");
  let $layerSelect = $(this).closest(".layer");
  $layerSelect.addClass("layer-select");
  setCurrentSelectIndex($layerSelect.attr("index"));

  // Thêm chi tiết layer
  $(".detail").attr("style", "display: none;");
  $(`.detail[index="${getCurrentSelectIndex()}"]`).attr(
    "style",
    "display: block;"
  );
});

// Xử lý khi thay đổi chi tiết layer
for (let i = 1; i <= getIndex(); i++) {
  // Thực hiện các công việc cần thiết trong vòng lặp
}

$("#fontSelect").change(function () {
  var font = $(this).val();
  $("#textInput").css("font-family", font);
});

$("#colorPicker").change(function () {
  var color = $(this).val();
  $("#textInput").css("color", color);
});

$("#fontSizeSelect").change(function () {
  var size = $(this).val() + "px";
  $("#textInput").css("font-size", size);
});

$("#boldBtn").click(function () {
  $("#textInput").toggleClass("bold");
});

$("#italicBtn").click(function () {
  $("#textInput").toggleClass("italic");
});

$("#resizable").draggable({
  drag: function (event, ui) {
    // Xử lý khi đang kéo thả ở đây
    console.log("Đang kéo thả...");
    $("#resizable").css({
      right: "auto",
      bottom: "auto",
    });
  },
});

// Tạo dữ liệu ban đầu
addLayerText("text", wish_title);
addLayerText("textLong", wish_content);
