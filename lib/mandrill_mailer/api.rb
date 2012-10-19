require 'json'
require 'net/https'

module MandrillMailer
  module API
    API_URL = 'https://mandrillapp.com/api'

    class << self
      def config(args)
        @api_version ||= args[:api_version] || '1.0'
        @format ||= args[:format] || 'json'
        @api_key = args[:api_key]
      end

      def call(api_method, *args)
        req_body = {key: @api_key}
        req_body.merge!(args.last) if args.last.is_a?(Hash)

        uri = URI.parse("#{API_URL}/#{@api_version}/#{api_method.to_s}/#{args.first.to_s}.#{@format}")

        req = Net::HTTP::Post.new(uri.path)
        req.body = JSON.dump(req_body)
        req['Content-Type'] = 'application/json'

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        @response = http.start {|htt| htt.request(req)}

        unless @response.code.to_i == 200
          error = JSON.parse(@response.body)
          raise API::Error.new(error["code"], error["message"])
        end
      end
    end

    class Error < StandardError
      def initialize(code, message)
        super "(#{code}) #{message}"
      end
    end
  end
end