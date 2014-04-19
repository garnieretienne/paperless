window.onLabelDropEvents = {}
window.onLabelDropEvents.updateDocumentLabels = ($label, $document) ->
  $label.addClass "is-label-processing"
  $.ajax $document.data("document-path"),
    method: "PATCH",
    data: {document: {label_ids: [$label.data("label-id")]}},
    dataType: "script",
    complete: ->
      $label.removeClass "is-label-processing"

$(document).on "page:change", ->

  $(".label.is-label-draggable").draggable
    start: (e, ui) ->
      $(ui.helper).addClass("is-label-dragging")
    helper: "clone"

  $(".is-label-droppable").droppable
    hoverClass: "is-label-droppable-hover"
    accept: ".label"
    drop: ( event, ui ) ->
      $target = $(event.target)
      $label = $(ui.draggable).clone()
        .addClass "is-label-pinned"
        .removeClass "is-label-draggable"
        .removeClass "ui-draggable"
      $li = $('<li>').html($label)
      $target.children(".label-list").append($li).append(" ");
      eventName = $target.data("on-label-drop")
      if typeof window["onLabelDropEvents"][eventName] == "function"
        window["onLabelDropEvents"][eventName]($label, $target)
