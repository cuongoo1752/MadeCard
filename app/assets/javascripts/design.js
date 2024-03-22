// set index default
var index = 0;
function getIndex() {
  index++;
  return index;
}

// Load data from controller
const wish_title = $("#wish_title").val();
const wish_content = $("#wish_content").val();

// set current select index default
const NOT_SELECT = -1;
var currentSelectIndex = NOT_SELECT;
function setCurrentSelectIndex(selectIndex) {
  currentSelectIndex = selectIndex;
}

function getCurrentSelectIndex() {
  return currentSelectIndex;
}

// Handle canvas
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

img.attr("src", $("#imageInput").attr("src"));

function addLayerText(type, content) {
  let indexLayer = getIndex();
  let $newLayer = $(`.layer-template-${type}`)
    .clone()
    .removeClass(`layer-template-${type}`)
    .removeAttr("style")
    .attr("index", indexLayer);
  $(".layers").append($newLayer);
  $(`.layer[index=${indexLayer}] .text`).val(content)

  if (type == "text" || type == "textarea") {
    let $newDetailLayer = $(".detail-template")
      .clone()
      .removeClass("detail-template")
      .attr("index", indexLayer);
    $(".row-board").append($newDetailLayer);
  }
}

$("#deleteLastLayer").click(function (event) {
  event.preventDefault();
  $(".layers li:last-child").remove();
});

$("#addText").click(function (event) {
  event.preventDefault();
  addLayerText("text");
});

$("#addLongText").click(function (event) {
  event.preventDefault();
  addLayerText("textarea");
});

$(".layers").on("click", ".delete-layer", function () {
  $(this).closest(".layer").remove();
});

$(".layers").on("click", ".layer", function () {
  // add UI layer
  $(".layer").removeClass("layer-select");
  let $layerSelect = $(this).closest(".layer");
  $layerSelect.addClass("layer-select");
  setCurrentSelectIndex($layerSelect.attr("index"));

  // display detail layer
  $(".detail").attr("style", "display: none;");
  $(`.detail[index="${getCurrentSelectIndex()}"]`).attr(
    "style",
    "display: block;"
  );
});

// Handle detail layer
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

addLayerText("text", wish_title);
addLayerText("textarea", wish_content);
