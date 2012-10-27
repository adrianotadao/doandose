class window.IdentityForm extends BaseForm
  constructor: ->
    super
      form: '#subscribe form.person'
      validates: [
        new NameValidation(),
        new SurnameValidation(),
        new BirthdateValidation(),
        new HeightValidation(),
        new WeightValidation(),

        new StreetValidation(),
        new NumberValidation(),
        new NeighborhoodValidation(),
        new CityValidation(),
        new StateValidation(),
        new ZipCodeValidation(),

        new PhoneValidation(),
        new DddPhoneValidation(),
        new DddCellphoneValidation(),
        new CellphoneValidation(),

        new EmailValidation(),
        new PasswordValidation(),
        new PasswordConfirmationValidation()
      ]