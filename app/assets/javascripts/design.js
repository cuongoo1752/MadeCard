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
  return `layer@${layerType}@${indexLayer}`;
}

function nameDetailLayer(layerAttribute, indexLayer) {
  return `detailLayer@${layerAttribute}@${indexLayer}`;
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
  $inputText.attr("index", indexLayer).val(content);

  // Thêm name có index để đánh dấu
  $inputText.attr("name", nameLayer(type, indexLayer));

  let defaultWidthText = 600;
  let defaultHeightText = 50;
  let topText = 70;
  let leftText = 75;

  let defaultWidthTextLong = 600;
  let defaultHeightTextLong = 200;
  let topTextLong = 130;
  let leftTextLong = 75;
  // Tạo detail của text
  let $newDetailLayer = $(".detail-template")
    .clone()
    .removeClass("detail-template")
    .attr("index", indexLayer);
  $(".row-board").append($newDetailLayer);

  $(`.detail[index=${indexLayer}] .input-text-font`)
    .attr("name", nameDetailLayer("font", indexLayer))
    .attr("index", indexLayer);

  $(`.detail[index=${indexLayer}] .input-text-color`)
    .attr("name", nameDetailLayer("color", indexLayer))
    .attr("index", indexLayer);

  $(`.detail[index=${indexLayer}] .input-text-size`)
    .attr("name", nameDetailLayer("size", indexLayer))
    .attr("index", indexLayer);

  $(`.detail[index=${indexLayer}] .input-text-align`)
    .attr("name", nameDetailLayer("text_align", indexLayer))
    .attr("index", indexLayer);

  $(`.detail[index=${indexLayer}] .input-text-vertical`)
    .attr("name", nameDetailLayer("vertical", indexLayer))
    .attr("index", indexLayer);

  $(`.detail[index=${indexLayer}] .input-text-type`)
    .attr("name", nameDetailLayer("text_type", indexLayer))
    .attr("index", indexLayer);

  if (type == "text") {
    $(`.detail[index=${indexLayer}] .input-text-width`)
      .attr("name", nameDetailLayer("width", indexLayer))
      .attr("index", indexLayer)
      .val(defaultWidthText);

    $(`.detail[index=${indexLayer}] .input-text-height`)
      .attr("name", nameDetailLayer("height", indexLayer))
      .attr("index", indexLayer)
      .val(defaultHeightText);

    $(`.detail[index=${indexLayer}] .input-text-top`)
      .attr("name", nameDetailLayer("top", indexLayer))
      .attr("index", indexLayer)
      .val(topText);

    $(`.detail[index=${indexLayer}] .input-text-left`)
      .attr("name", nameDetailLayer("left", indexLayer))
      .attr("index", indexLayer)
      .val(leftText);
  } else if (type == "textLong") {
    $(`.detail[index=${indexLayer}] .input-text-width`)
      .attr("name", nameDetailLayer("width", indexLayer))
      .attr("index", indexLayer)
      .val(defaultWidthTextLong);

    $(`.detail[index=${indexLayer}] .input-text-height`)
      .attr("name", nameDetailLayer("height", indexLayer))
      .attr("index", indexLayer)
      .val(defaultHeightTextLong);

    $(`.detail[index=${indexLayer}] .input-text-top`)
      .attr("name", nameDetailLayer("top", indexLayer))
      .attr("index", indexLayer)
      .val(topTextLong);

    $(`.detail[index=${indexLayer}] .input-text-left`)
      .attr("name", nameDetailLayer("left", indexLayer))
      .attr("index", indexLayer)
      .val(leftTextLong);
  }

  // Tạo box text
  let $newBoxLayerText = $(`.box-layer-text-template`)
    .clone()
    .removeClass(`box-layer-text-template`)
    .removeAttr("style")
    .attr("index", indexLayer);
  $(".canvas-board").append($newBoxLayerText);
  // Gán giá trị default
  if (type == "text") {
    $(`.box-layer-text[index=${indexLayer}]`).css({
      width: defaultWidthText,
      height: defaultHeightText,
      top: topText,
      left: leftText,
    });
  } else if (type == "textLong") {
    $(`.box-layer-text[index=${indexLayer}]`).css({
      width: defaultWidthTextLong,
      height: defaultHeightTextLong,
      top: topTextLong,
      left: leftTextLong,
    });
  }
  $(`.box-layer-text[index=${indexLayer}] .text-content`).html(content);

  // Thêm sự kiện drag
  $(".box-layer").draggable({
    drag: function (event, ui) {
      let indexLayerDrag = $(this).attr("index");
      let position = $(this).position();
      console.log(position.top, position.left);

      $(`.detail[index=${indexLayerDrag}] .input-text-top`).val(position.top);

      $(`.detail[index=${indexLayerDrag}] .input-text-left`).val(position.left);
    },
  });

  // Khi sửa nội dung layer
}

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
  let indexLayer = $(this).closest(".layer").attr("index");
  $(this).closest(".layer").remove();
  $(`.box-layer-text[index=${indexLayer}]`).remove();
  $(`.detail[index=${indexLayer}]`).remove();
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

$(document).ready(function () {
  $(".input-text-font").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "font-family",
      $(this).val()
    );
  });

  $(".input-text-color").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "color",
      $(this).val()
    );
  });

  $(".input-text-size").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "font-size",
      `${$(this).val()}px`
    );
  });

  $(".input-text-align").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "text-align",
      $(this).val()
    );
  });

  $(".input-text-vertical").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "vertical-align",
      $(this).val()
    );
  });

  $(".input-text-type").change(function () {
    let indexLayer = $(this).attr("index");
    if ($(this).val() == "bold") {
      $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
        "font-weight",
        $(this).val()
      );
    } else {
      $(`.box-layer-text[index=${indexLayer}] .text-content`).css({
        "font-style": $(this).val(),
        "font-weight": "normal",
      });
    }
  });

  $(".input-text-width").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}]`).css("width", $(this).val());
  });

  $(".input-text-height").change(function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}]`).css("height", $(this).val());
  });

  $(".text").on("input", function () {
    let indexLayer = $(this).attr("index");
    $(`.box-layer-text[index=${indexLayer}] .text-content`).text($(this).val());
  });
});

// Tạo dữ liệu ban đầu
addLayerText("text", wish_title);
addLayerText("textLong", wish_content);
