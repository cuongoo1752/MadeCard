var maxId = $("#max-id").val();
function AddAndGetId() {
  maxId++;
  return maxId;
}

function addCategory() {
  let id = AddAndGetId();
  let $newCategory = $(`.category-template`)
    .clone()
    .removeClass(`category-template`)
    .removeAttr("style")
    .attr("id", id);
  $(".categories").append($newCategory);

  $(`.category[id=${id}] .form-control[name=type]`).attr("name", `type@${id}`);
  $(`.category[id=${id}] .form-control[name=content]`).attr(
    "name",
    `content@${id}`
  );
  $(`.category[id=${id}] .form-control[name=status]`).attr("name", `status@${id}`);
}

$("#addCategory").click(function (event) {
  event.preventDefault();
  addCategory();
});
