#!/usr/bin/env ruby
module QRCode
  QRMODE = {
    :mode_number        => 1 << 0,
    :mode_alpha_numk    => 1 << 1,
    :mode_8bit_byte     => 1 << 2,
    :mode_kanji         => 1 << 3
  }

  class QR8bitByte
    attr_reader :mode

    def initialize( data )
      @mode = QRMODE[:mode_8bit_byte]
      @data = data;
    end

    def get_length
      @data.size
    end

    def write( buffer )
      ( 0...@data.size ).each do |i|
        c = @data[i]
        c = c.ord if c.respond_to?(:ord)
        buffer.put( c, 8 )
      end
    end
  end

end