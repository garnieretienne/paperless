$(document).on "page:change", ->

  $(".document-upload").each ->
    $link = $(this).children(".document-upload-link")
    $form = $(this).children(".document-upload-form")
    $progress = $(this).children(".document-upload-progress")
    $progressQueue = $progress.children(".document-upload-progress-queue")
    $returnButton = $progress.children(".document-upload-progress-return-button")
    $input = $form.children("input[type=file]")
    $overlay = $(".overlay")
    csrfToken = $("meta[name='csrf-token']").attr("content")

    $link.click (e) ->
      e.preventDefault()
      $input.trigger 'click'

    $input.change ->
      $progress.addClass "is-document-upload-progress-active"
      $overlay.addClass "is-overlay-active"
      fileList = $input.prop("files")
      uploadCounter = fileList.length
      for file in fileList
        do (file) ->
          moduleId = "progress-bar-" + Date.now()
          render_module "progress_bar", id: moduleId, filename: file.name, (html) ->
            $progressQueue.append html
            $progressBar = $("##{moduleId}").find(".progress-bar-container-percent")
            formData = new FormData()
            formData.append $input.attr("name"), file, file.name
            $.ajax $form.attr("action"), {
              type: "POST",
              xhr: () ->
                xhr = new XMLHttpRequest()
                xhr.upload.addEventListener "progress", (event) ->
                  current = ((event.loaded  * 100) / event.total)
                  $progressBar.css "width", current + "%"
                , false
                return xhr
              data: formData,
              processData: false,
              contentType: false,
              success: (data) ->
                $progressBar.addClass "is-progress-bar-container-percent-complete"
              complete: ->
                uploadCounter--
                if uploadCounter == 0
                  $returnButton.removeClass "is-button-disabled"
            }
