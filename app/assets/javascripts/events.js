var maxId = $("#max-id").val();
function AddAndGetId() {
  maxId++;
  return maxId;
}

function addEvent() {
  let id = AddAndGetId();
  let $newEvent = $(`.event-template`)
    .clone()
    .removeClass(`event-template`)
    .removeAttr("style")
    .attr("id", id);
  $(".events").append($newEvent);

  $(`.event[id=${id}] .form-control[name=type]`).attr("name", `type@${id}`);
  $(`.event[id=${id}] .form-control[name=content]`).attr(
    "name",
    `content@${id}`
  );
  $(`.event[id=${id}] .form-control[name=status]`).attr("name", `status@${id}`);
}

$("#addEvent").click(function (event) {
  event.preventDefault();
  addEvent();
});
