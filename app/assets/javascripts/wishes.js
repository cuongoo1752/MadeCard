var maxId = $("#max-id").val();
function AddAndGetId() {
  maxId++;
  return maxId;
}

function addWish() {
  let id = AddAndGetId();
  let $newWish = $(`.wish-template`)
    .clone()
    .removeClass(`wish-template`)
    .removeAttr("style")
    .attr("id", id);
  $(".wishes").append($newWish);

  $(`.wish[id=${id}] .form-control[name=type]`).attr("name", `type@${id}`);
  $(`.wish[id=${id}] .form-control[name=content]`).attr(
    "name",
    `content@${id}`
  );
  $(`.wish[id=${id}] .form-control[name=status]`).attr("name", `status@${id}`);
}

$("#addWish").click(function (event) {
  event.preventDefault();
  addWish();
});
