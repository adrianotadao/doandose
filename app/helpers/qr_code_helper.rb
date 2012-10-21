module QrCodeHelper
  def qr_code(qr)

    haml_tag :table, {:class => 'qrcode'} do
      qr.modules.each_index do |x|

        haml_tag :tr do
          qr.modules.each_index do |y|

            if qr.dark?(x,y)
              haml_tag :td, class: 'black'
            else
              haml_tag :td, class: 'white'
            end

          end
        end
      end

    end

  end
end