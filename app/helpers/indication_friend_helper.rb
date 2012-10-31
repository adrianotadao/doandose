module IndicationFriendHelper
  def message(attr)
    "Ola seu amigo.
    Esta convidando voce para partifipar da notificacao:
      #{attr.title}, com a quantidade de #{attr.quantity} bolsas de sangue
      do tipo #{attr.blood.name}.

      Acesse: #{Settings.domain}#{attr.slug}
    "
  end
end