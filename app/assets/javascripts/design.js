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

// Khởi tại giá tại positions
var positions = {};

// Tạo giá trị từ controller
const wish_title = $("#wish_title").val();
const wish_content = $("#wish_content").val();
const public_flg = $("#public_flg").val();
const picture_flg = $("#picture_flg").val();
const picture_url = $("#picture_url").val();
const card_flg = $("#card_flg").val();

// Khởi tạo giá trị index đang chọn
const NOT_SELECT = -1;
var currentSelectIndex = NOT_SELECT;
function setCurrentSelectIndex(selectIndex) {
  currentSelectIndex = selectIndex;
}

function getCurrentSelectIndex() {
  return currentSelectIndex;
}

if (public_flg == 1) {
  // Ẩn các phần tử
  $(".tools-board").hide();
  $(".detail-board").hide();
  $(".container").addClass("d-flex justify-content-center");
}

// Xử lý canvas
const imageInput = $("#imageInput");

var img = $("<img/>");
img.on("load", function () {
  var maxWidth = 800;
  var maxHeight = 700;
  var canvas = $("<canvas/>")[0];
  var width = this.width;
  var height = this.height;

  if (width > maxWidth || height > maxHeight) {
    var ratio = Math.min(maxWidth / width, maxHeight / height);
    width *= ratio;
    height *= ratio;
  }

  canvas.width = width;
  canvas.height = height;

  var ctx = canvas.getContext("2d");
  ctx.drawImage(this, 0, 0, width, height);

  $(".canvas-board").append(canvas);
  $("canvas").attr("id", "designCanvas");
  $(".canvas-board").css("width", width).css("height", height);
});

function nameLayer(layerType, indexLayer) {
  return `layer@${layerType}@${indexLayer}`;
}

function nameDetailLayer(layerAttribute, indexLayer) {
  return `detailLayer@${layerAttribute}@${indexLayer}`;
}
if (picture_flg == 1) {
  img.attr("src", picture_url);
} else {
  img.attr("src", $("#imageInput").attr("src"));
}

function isObjectEmpty(objectName) {
  return (
    objectName &&
    Object.keys(objectName).length === 0 &&
    objectName.constructor === Object
  );
}

// Chọn vào hiện thị phần chi tiết của layer
function selectAndDisplayDetail(indexCurrent) {
  if (indexCurrent == getCurrentSelectIndex()) {
    return;
  }

  setCurrentSelectIndex(indexCurrent);
  $(".detail").attr("style", "display: none;");
  $(`.detail[index="${getCurrentSelectIndex()}"]`).attr(
    "style",
    "display: block;"
  );
}

// Cập nhật giá trị vị trí
function updatePositionLayer(event) {
  let indexCurrent = $(event.target).attr("index");
  let position = $(event.target).position();
  $(`.detail[index=${indexCurrent}] .input-text-top`).val(position.top);
  $(`.detail[index=${indexCurrent}] .input-text-left`).val(position.left);
}

// Thêm layer text mới
function addLayerText(type, content = "", layerDetail = {}) {
  // Giá giá trị mặc định
  if (isObjectEmpty(layerDetail)) {
    layerDetail = {
      color: "#000000",
      content: content,
      font: "Arial",
      size: 12,
      text_align: "Left",
      text_type: "normal",
      vertical: "top",
    };

    if (type == "text") {
      layerDetail["width"] = 600;
      layerDetail["height"] = 50;
      layerDetail["top"] = 70;
      layerDetail["left"] = 75;
    } else if (type == "textLong") {
      layerDetail["width"] = 600;
      layerDetail["height"] = 200;
      layerDetail["top"] = 130;
      layerDetail["left"] = 75;
    }
  }
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

  // Tạo detail của text
  let $newDetailLayer = $(".detail-template")
    .clone()
    .removeClass("detail-template")
    .attr("index", indexLayer);
  $(".row-board").append($newDetailLayer);

  // Font
  $(`.detail[index=${indexLayer}] .input-text-font`)
    .attr("name", nameDetailLayer("font", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["font"]);

  // Màu sắc
  $(`.detail[index=${indexLayer}] .input-text-color`)
    .attr("name", nameDetailLayer("color", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["color"]);

  // Kích thước chữ
  $(`.detail[index=${indexLayer}] .input-text-size`)
    .attr("name", nameDetailLayer("size", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["size"]);

  // Căn ngang
  $(`.detail[index=${indexLayer}] .input-text-align`)
    .attr("name", nameDetailLayer("text_align", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["text_align"]);

  // Căn dọc
  $(`.detail[index=${indexLayer}] .input-text-vertical`)
    .attr("name", nameDetailLayer("vertical", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["vertical"]);

  // Loại chữ
  $(`.detail[index=${indexLayer}] .input-text-type`)
    .attr("name", nameDetailLayer("text_type", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["text_type"]);

  // Chiều rộng
  $(`.detail[index=${indexLayer}] .input-text-width`)
    .attr("name", nameDetailLayer("width", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["width"]);

  // Chiều dài
  $(`.detail[index=${indexLayer}] .input-text-height`)
    .attr("name", nameDetailLayer("height", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["height"]);

  // Top
  $(`.detail[index=${indexLayer}] .input-text-top`)
    .attr("name", nameDetailLayer("top", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["top"]);

  // Left
  $(`.detail[index=${indexLayer}] .input-text-left`)
    .attr("name", nameDetailLayer("left", indexLayer))
    .attr("index", indexLayer)
    .val(layerDetail["left"]);

  // Tạo box text
  let $newBoxLayerText = $(`.box-layer-text-template`)
    .clone()
    .removeClass(`box-layer-text-template`)
    .removeAttr("style")
    .attr("index", indexLayer);
  $(".canvas-board").append($newBoxLayerText);
  // Gán vị trí
  $(`.box-layer-text[index=${indexLayer}]`).css({
    "font-family": layerDetail["font"],
    color: layerDetail["color"],
    "font-size": layerDetail["size"],
    "line-height": layerDetail["size"],
    "text-align": layerDetail["text_align"],
    "vertical-align": layerDetail["vertical"],
    width: layerDetail["width"],
    height: layerDetail["height"],
    top: layerDetail["top"],
    left: layerDetail["left"],
  });

  if (layerDetail["text_type"] == "bold") {
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css(
      "font-weight",
      layerDetail["text_type"]
    );
  } else {
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css({
      "font-style": layerDetail["text_type"],
      "font-weight": "normal",
    });
  }

  $(`.box-layer-text[index=${indexLayer}] .text-content`).html(content);

  if (public_flg != 1) {
    // Thêm sự kiện thay đổi kích thước phẩn tử
    positions[`index@${indexLayer}`] = { x: 0, y: 0 };
    interact(".box-layer").resizable({
      edges: { top: true, left: true, bottom: true, right: true },
      listeners: {
        move: function (event) {
          let { x, y } = event.target.dataset;
          x = (parseFloat(x) || 0) + event.deltaRect.left;
          y = (parseFloat(y) || 0) + event.deltaRect.top;

          let indexCurrent = $(event.target).attr("index");
          // Chỉnh kích thước ô
          Object.assign(event.target.style, {
            width: `${event.rect.width}px`,
            height: `${event.rect.height}px`,
            transform: `translate(${x}px, ${y}px)`,
          });
          // Gán chiều dài, chiều rộng vào input form
          $(`.detail[index=${indexCurrent}] .input-text-width`).val(
            event.rect.width
          );
          $(`.detail[index=${indexCurrent}] .input-text-height`).val(
            event.rect.height
          );

          // Lưu giá trị
          event.target.dataset.x = x;
          event.target.dataset.y = y;
          positions[`index@${indexCurrent}`].x = x;
          positions[`index@${indexCurrent}`].y = y;
          selectAndDisplayDetail(indexCurrent);
          updatePositionLayer(event);
        },
      },
    });

    // Thêm sự kiện phẩn tử có thể di chuyển
    interact(".box-layer").draggable({
      listeners: {
        start(event) {},
        move(event) {
          let indexCurrent = $(event.target).attr("index");
          positions[`index@${indexCurrent}`].x += event.dx;
          positions[`index@${indexCurrent}`].y += event.dy;
          let x = positions[`index@${indexCurrent}`].x;
          let y = positions[`index@${indexCurrent}`].y;
          selectAndDisplayDetail(indexCurrent);

          // Lưu giá trị
          event.target.style.transform = `translate(${x}px, ${y}px)`;
          event.target.dataset.x = x;
          event.target.dataset.y = y;
          updatePositionLayer(event);
        },
      },
    });
  }
}

// Tải ảnh về
$("#downloadImage").click(function (event) {
  event.preventDefault();
  html2canvas($(".canvas-board")[0]).then(function (canvas) {
    var link = document.createElement("a");
    link.download = "image.png";
    link.href = canvas.toDataURL();
    link.click();
  });
});

if (public_flg != 1) {
  $(".canvas-board")
    .on("mouseenter", function () {
      $(".box-layer").css("border", "1px solid #4a98f7");
      $(".resizer").css("background-color", "#4a98f7");
    })
    .on("mouseleave", function () {
      $(".box-layer").css("border", "1px solid transparent");
      $(".resizer").css("background-color", "transparent");
    });
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
  let indexCurrent = $layerSelect.attr("index");

  // Hiển thị chi tiết layer
  selectAndDisplayDetail(indexCurrent);
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
    $(`.box-layer-text[index=${indexLayer}] .text-content`).css({
      "font-size": `${$(this).val()}px`,
      "line-height": `${$(this).val()}px`,
    });
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

if (card_flg == 1) {
  layers.forEach(function (layer) {
    switch (layer.layer_type) {
      case "Text":
        let layerDetail = layer["layer_detail"];
        let type = layerDetail["is_long"] ? "textLong" : "text";
        addLayerText(type, layerDetail["content"], layerDetail);
        break;
    }
  });
} else {
  // Tạo dữ liệu ban đầu
  addLayerText("text", wish_title);
  addLayerText("textLong", wish_content);
}
