module PeopleHelper
  def path_locale(attribute)
    t("label.user.confirmation_step.#{attribute}")
  end
end
