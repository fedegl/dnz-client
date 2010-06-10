require File.dirname(__FILE__) + '/../spec_helper'
require 'dnz/user'

include DNZ

describe User do
  before do
    @consumer = mock(:consumer)
    @client = mock(:client, :oauth_consumer => @consumer)
    Client.stub!(:connection).and_return(@client)
  end

  describe '#request_token' do
    subject { @user.request_token }

    context 'user initialized with request_token' do
      before { @user = User.new(:request_token => {:token => 'abc', :secret => '123'}) }
      its(:token) { should == 'abc' }
      its(:secret) { should == '123' }
    end

    context 'from consumer' do
      before { @user = User.new }

      it 'should get the request token from the client consumer' do
        @request_token = mock(:request_token)
        @consumer.should_receive(:get_request_token).and_return(@request_token)
        subject.should == @request_token
      end
    end
  end

  describe '#authorize_url' do
    before do
      @user = User.new
      @request_token = mock(:request_token)
      @user.stub!(:request_token).and_return(@request_token)
    end


    it 'should return the request token authorize_url' do
      @mock_url = mock(:url)
      @request_token.should_receive(:authorize_url).and_return(@mock_url)
      @user.authorize_url.should == @mock_url
    end
  end

  describe '#access_token' do
    subject { @user.access_token }

    context 'user initialized with access_token' do
      before { @user = User.new(:access_token => {:token => 'abc', :secret => '123'}) }
      its(:token) { should == 'abc' }
      its(:secret) { should == '123' }
    end

    context 'from request token' do
      before do
        @user = User.new
        @request_token = mock(:request_token)
        @access_token = mock(:access_token)
        @user.stub!(:request_token).and_return(@request_token)
      end

      context 'oauth_verifier available' do
        it 'should get the access token from the request token' do
          @user = User.new(:oauth_verifier => 'abc')
          @user.stub!(:request_token).and_return(@request_token)
          @request_token.should_receive(:get_access_token).with(:oauth_verifier => 'abc').and_return(@access_token)
          @user.access_token.should == @access_token
        end
      end

      context 'oauth_verifier not available' do
        it { should be_nil }
      end
    end
  end

  describe '#authorized?' do
    before { @user = User.new }

    context 'test not specified' do
      subject { @user.authorized? }

      context 'no access token' do
        before { @user.stub!(:access_token).and_return(nil) }
        it { should be_false }
      end

      context 'access token available' do
        before { @user.stub!(:access_token).and_return(OAuth::AccessToken.new('abc', '123')) }
        it { should be_true }
      end

      context 'access token raises error' do
        before { @user.stub!(:access_token).and_raise(Exception.new) }
        it { should be_false }
      end
    end

    context 'test specified' do
      subject { @user.authorized?(true) }

      context 'no access token' do
        before { @user.stub!(:access_token).and_return(nil) }
        it { should be_false }
      end

      context 'access token available' do
        before do
          @access_token = mock(:access_token)
          @user.stub!(:access_token).and_return(@access_token)
        end

        context 'get returns HTTPSuccess' do
          before do
            @access_token.stub!(:get).and_return(Net::HTTPSuccess.new(nil, 200, ''))
          end

          it { should be_true }
        end

        context 'get returns any other status' do
          before do
            @access_token.stub!(:get).and_return(Net::HTTPNotFound.new(nil, 200, ''))
          end
          it { should be_false }
        end
      end

      context 'access token raises error' do
        before { @user.stub!(:access_token).and_raise(Exception.new) }
        it { should be_false }
      end
    end

  end

  describe '#client' do
    subject { @user.client }

    context 'client is passed to new user' do
      before do
        @client = Client.new('abc')
        @user = User.new(@client)
      end

      it { should == @client }
    end

    context 'client is not passed to new user' do
      before do
        @client = Client.new('abc')
        Client.stub!(:connection).and_return(@client)
        @user = User.new
      end

      it { should == @client }
    end
  end
end
