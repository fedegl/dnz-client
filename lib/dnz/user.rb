require 'oauth'

module DNZ
  # This class represents a DigitalNZ user. It can be used to authenticate users with DigitalNZ as
  # an OAuth provider. This is a wrapper around the OAuth library.
  #
  # In order to make use of this class your application must have been registered with DigitalNZ
  # at http://api.digitalnz.org/oauth_clients. The consumer token and secret need to be passed
  # to the Client class when connecting to the service.
  #
  # === Example
  #   Client.connect('abc', :oauth_token => 'consumer key/token', :oauth_secret => 'consumer secret')
  #   user = User.new
  #   session[:dnz_oauth_request] = {:token => user.request_token.token, :secret => user.request_token.secret}
  #   user.authorize_url => 'http://api.digitalnz.org/oauth/authorize?oauth_token=xxx'
  #
  # After directing the user to visit the above URL a callback will be made to the URL you provided
  # during the oauth client signup process.
  #
  #   user = User.new(:request_token => session[:dnz_oauth_request], :oauth_verifier => params[:oauth_verifier])
  #   user.authorized? => true
  #
  class User
    # The options passed to the user object from User.new
    attr_reader :oauth_options

    # Create a new User object. This can take an optional client, and a hash of options:
    #
    #   User.new(@client, {})
    #   User.new(@client)
    #   User.new
    #
    # If no client is specified then the default Client.connection will be used. Make sure to call
    # Client.connect before using this class.
    #
    # === Available options:
    # * <tt>:request_token</tt> - A hash containing a :token and a :secret value for constructing the request token
    # * <tt>:access_token</tt> - A hash containing a :token and a :secret value for constructing the access token
    # * <tt>:oauth_verifier</tt> - The verification string that is returned as a parameter from the authorize_url
    #
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
        self.request_token = OAuth::RequestToken.new(client.oauth_consumer, token_options[:token], token_options[:secret])
      end

      if token_options = oauth_options[:access_token]
        self.access_token = OAuth::AccessToken.new(client.oauth_consumer, token_options[:token], token_options[:secret])
      end
    end

    # The client used by this object
    def client
      @client || Client.connection
    end

    # Get a request token for the initial OAuth authorization process
    def request_token
      @request_token ||= client.oauth_consumer.get_request_token
    end

    # Set the request token
    def request_token=(token)
      @request_token = token
    end

    # Get the authorize_url from the request token
    def authorize_url
      request_token.authorize_url
    end

    # The access token. If an access token is not already available this
    # will attempt to create one if an oauth verifier is available.
    def access_token
      @access_token ||= begin
        if oauth_options[:oauth_verifier]
          request_token.get_access_token(:oauth_verifier => oauth_options[:oauth_verifier])
        else
          request_token.get_access_token
        end
      end
    end

    # Set the access token.
    def access_token=(token)
      @access_token = token
    end

    # Test that this user is authorized with DigitalNZ. This is assumed to be true if an
    # access token is available. Calling the optional test parameter will *always* make
    # an HTTP connection to DigitalNZ to test the authorization.
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

    def resource
      @resource ||= begin
        if authorized?
          DNZ::Resource.parse(get('/user.xml').body)
        end
      end
    end

    def method_missing(method, *args, &block)
      if authorized?
        resource.__send__(method, *args, &block)
      else
        super
      end
    end

    private

    def get(url, options = {})
      options = {:api_key => client.api_key}.merge(options)
      access_token.get('%s?%s' % [url, options.to_query])
    end
  end
end