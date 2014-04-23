window.labelModule = {}

window.labelModule.enableDeleteLink = ($label) ->
  $label.children(".label-delete-link").click (e) ->
    e.preventDefault()
    $document = $label.closest(".document-list-entry")
    $label.addClass "is-label-processing"
    $.ajax $document.data("detach-label-document-path"),
      method: "PATCH",
      data: {label_id: $label.data("label-id")},
      dataType: "script",
      complete: ->
        $label.removeClass "is-label-processing"
        $label.remove()

$(document).on "page:change", ->
  $(".label").each ->
    labelModule.enableDeleteLink $(this)

$(document).on "label:attached", (e, label) ->
  labelModule.enableDeleteLink $(label)
