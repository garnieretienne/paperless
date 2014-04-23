$(document).on "page:change", ->

  $(".action-list").each ->
    $actionList = $(this)
    if !$actionList.hasClass("is-always-visible")
      $parent = $actionList.parent()
      $parent.hover ->
        $actionList.addClass("is-action-list-active")
      , ->
        $actionList.removeClass("is-action-list-active")