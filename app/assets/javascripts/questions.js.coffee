$ ->
  $("input#new_tag").change (event) ->
    $this = $(this)
    tagName = $this.val()
    checkbox = "<input id='tag_#{tagName}' type='checkbox' value='#{tagName}' name='question[tag_array][]' checked='checked'>"
    tag = "<label for='tag_#{tagName}' class='checkbox inline'>#{checkbox}#{tagName}</label>"

    $("#tags").append tag
    $this.val ""

    false

  $('form.new_vote').on 'ajax:success', (e, data, status, xhr)->
    $(this).parents(".rating").find(".rating-number").html data["rating"]
    $(this).remove()

  $('form#new_answer').on 'ajax:success', (e, data, status, xhr)->
    $("#answers").append data
    $(this).find("#answer_text").val('')
