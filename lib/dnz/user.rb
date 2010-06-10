require 'oauth'

module DNZ
  class User
    attr_reader :oauth_options

    def initialize(*args)
      if args.first.is_a?(DNZ::Client)
        @client = args.shift
      end

      if args.first.is_a?(Hash)
        @oauth_options = args.first
      else
        @oauth_options = {}
      end

      if token_options = oauth_options[:request_token]
        self.request_token = OAuth::RequestToken.new(consumer, token_options[:token], token_options[:secret])
      end

      if token_options = oauth_options[:access_token]
        self.access_token = OAuth::AccessToken.new(consumer, token_options[:token], token_options[:secret])
      end
    end

    def client
      @client || Client.connection
    end

    def consumer
      client.oauth_consumer
    end

    def request_token
      @request_token ||= consumer.get_request_token
    end

    def request_token=(token)
      @request_token = token
    end

    def authorize_url
      request_token.authorize_url
    end

    def oauth_verifier
      oauth_options[:oauth_verifier]
    end

    def access_token
      @access_token ||= request_token.get_access_token(:oauth_verifier => oauth_verifier)
    end

    def access_token=(token)
      @access_token = token
    end

    def authorized?(test = false)
      if test
        if access_token
          access_token.get('/oauth/test_request').is_a?(Net::HTTPSuccess)
        else
          false
        end
      else
        !!access_token
      end

    rescue Exception => e
      false
    end
  end
end