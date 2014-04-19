$(document).on "page:change", ->

  $(".label.is-label-draggable").draggable
    start: (e, ui) ->
      $(ui.helper).addClass("is-label-dragging")
    helper: "clone"

  $(".is-label-droppable").droppable
    hoverClass: "is-label-droppable-hover"
    drop: ( event, ui ) ->
      $target = $(event.target)
      $label = $(ui.draggable).clone()
        .addClass("is-label-pinned")
        .removeClass("is-label-draggable")
        .removeClass("ui-draggable")
      $li = $('<li>').html($label)
      $target.children(".label-list").append($li).append(" ");