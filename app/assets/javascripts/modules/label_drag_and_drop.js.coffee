window.onLabelDropEvents = {}

window.onLabelDropEvents.updateDocumentLabels = ($label, $document, callback) ->
  $labelList = $document.children(".label-list")
  labelIdsList = []
  $labelList.children().each (index) ->
    labelIdsList.push $(this).children(".label").data("label-id")
  if labelIdsList.indexOf($label.data("label-id")) == -1
    $label.addClass "is-label-pinned"
      .removeClass "is-label-draggable"
      .removeClass "ui-draggable"
      .addClass "is-label-processing"
    $labelList.append($('<li>').html($label)).append(" ");
    $.ajax $document.data("attach-label-document-path"),
      method: "PATCH",
      data: {label_id: $label.data("label-id")},
      dataType: "script",
      complete: ->
        $label.removeClass "is-label-processing"
        callback()
  else
    callback()


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
      eventName = $target.data("on-label-drop")
      if typeof window["onLabelDropEvents"][eventName] == "function"
        window["onLabelDropEvents"][eventName] $label, $target, ->
          $(document).trigger "label:attached", $label
