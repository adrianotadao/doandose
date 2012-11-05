module IndicationFriendHelper
  def subject
    'Precisamos da sua ajuda para salvar uma vida !'
  end

  def message(attr)
    "Ola seu amigo.
      \nEsta convidando voce para partifipar da notificacao:
      \n#{attr.title}, com a quantidade de #{attr.quantity} bolsas de sangue do tipo #{attr.blood.name}.

      \n\nAcesse: #{Settings.domain}#{attr.slug}
    "
  end
end