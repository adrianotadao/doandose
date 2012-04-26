class window.Person
  minimalForm: $('#minimal_form')
  contactForm: $('#contact')
  addressForm: $('#address')
  userForm: $('#user')
  userName: $('#person_user_attributes_username')
  userEmail: $('#person_user_attributes_email')
  userPassword: $('#person_user_attributes_password')
  userPasswordConfirmation: $('#person_user_attributes_password_confirmation')
  userInputAll: $('#user').find($('dl.form input'))
  buttonSave: $('.button.save')
  buttonNext: $('.button.next')
  alert: $('#alert')
  birthday: $('#person_birthday').mask('99/99/9999')

  constructor: ->
    @showForms()
    @verifyInputs()
    @alert()

  showForms: ->
    if @verifyValue()
      @minimalForm.hide()
      @contactForm.hide()
      @addressForm.hide()    
      @buttonSave.hide() 
      @buttonNext.show()
    else
      @minimalForm.show()
      @contactForm.show()
      @addressForm.show()   
      @buttonSave.show() 
      @buttonNext.hide()       

  verifyValue: ->
    if @userName.val() == '' || @userEmail.val() == '' || @userPassword.val() == '' || @userPasswordConfirmation.val()  == ''
      true
    else
      false

  verifyInputs: ->
    @showForms()

  alert: ->
    @buttonNext.click => 
      if @verifyValue()
        @alert.val('<p> Preencha todos os dados para prosseguir.</p>') 
      else
        @alert.empty()  
