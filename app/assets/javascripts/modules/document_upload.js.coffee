$(document).on "page:change", ->

  $(".document-upload").each ->
    $link = $(this).children(".document-upload-link")
    $form = $(this).children(".document-upload-form")
    $input = $form.children("input[type=file]")

    $link.click (e) ->
      e.preventDefault()
      $input.trigger 'click'

    $input.change ->
      $form.submit()