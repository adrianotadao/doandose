class window.IdentityForm extends BaseForm
  constructor: ->
    super
      form: '#subscribe form.new_person'
      validates: [
        new UsernameValidation()
      ]