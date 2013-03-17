$ ->
  $("input#new_tag").change (event) ->
    $this = $(this)
    tagName = $this.val()
    label = "<label for='tag_#{tagName}'>#{tagName}</label>"
    checkbox = "<input id='tag_#{tagName}' type='checkbox' value='#{tagName}' name='question[tag_array][]' checked='checked'>"

    $("#tags").append label + checkbox
    $this.val ""

    false