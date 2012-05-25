class window.PasswordStrength
  desc: ["Very Weak", "Weak", "Better", "Medium", "Strong", "Strongest"]
  password: $('#person_user_attributes_password').val()

  constructor: ->
    @scores(@password)
    document.getElementById("passwordDescription").innerHTML = @desc[@scores()]
    document.getElementById("passwordStrength").className = "strength #{@scores()}"
    
  scores: (value) =>
    console.log value
    score = 0
    score++ if value.length > 6
    score++ if value.match(/[a-z]/) and password.match(/[A-Z]/)
    score++ if value.match(/\d+/)
    score++ if value.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)
    score++ if value.length > 12
