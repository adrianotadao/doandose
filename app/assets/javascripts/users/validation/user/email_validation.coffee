class window.EmailValidation extends BaseValidation
  constructor: ->
    email = '#person_user_attributes_email'
    super(email)
    @request = undefined

    $(email).change (e) =>
      value = $(e.currentTarget).val().replace(/\s/g, '')
      $(e.currentTarget).val( value.toLowerCase() )

  run: ->
    expReg = /^([a-zA-Z0-9\.\-\+]+[a-zA-Z0-9._-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    switch
      when @field.val() == '' then @setStatus('error', 'Preencha o seu e-mail')
      when @field.val().length > 100 then @setStatus('error', 'Excedeu o limite')
      when !expReg.test(@field.val()) then @setStatus('error', 'E-mail inválido')
      else
        @setStatus('pending')
        @request.abort() if @request? && @request == undefined
        @request = $.ajax
          type: 'POST'
          url: '/cadastro/email-em-uso/'
          data: email: @field.val()
          beforeSend: =>
            @setStatus('pending')
          success: (data) =>
            if data
              @setStatus('valid')
            else
              @setStatus('error', 'E-mail já existe')
          complete: (data) =>
            @removeLoading()
