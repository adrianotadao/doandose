class window.IdentityForm extends BaseForm
  constructor: ->
    super
      form: '#subscribe form.new_person'
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
      ]