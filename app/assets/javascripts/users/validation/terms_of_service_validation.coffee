class window.TermsOfServiceValidation extends BaseValidation
  constructor: ->
    super('#users_user_terms_of_service')
    @field = $.extend(@field, new TermsOfServiceCheckbox())

  run: ->
    if @field.val()
      @setStatus('valid')
    else
      @setStatus('error', 'Leia e aceite')

  class window.TermsOfServiceCheckbox
    val: -> this.is(':checked')