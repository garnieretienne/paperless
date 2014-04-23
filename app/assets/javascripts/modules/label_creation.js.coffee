$(document).on "page:change", ->

  $(".label-creation").each ->
    $link = $(this).children(".label-creation-link")
    $form = $(this).children(".label-creation-form")
    $cancelLink = $(this).find(".label-creation-cancel-link:first")

    $link.click (e) ->
      e.preventDefault()
      $link.fadeOut 100, ->
        $form.fadeIn(100)

    $cancelLink.click (e) ->
      e.preventDefault()
      $form.fadeOut 100, ->
        $link.fadeIn(100)