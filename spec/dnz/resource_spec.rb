require File.dirname(__FILE__) + '/../spec_helper'
require 'dnz/resource'

include DNZ

describe Resource do
  before do
    @xml = '<user><login>Jeremy</login><api-key>abc</api-key>'
    @user = DNZ::Resource.parse(@xml)
  end

  describe '::parse' do

  end
  
  describe 'method missing' do
    context '#login' do
      subject { @user.login }
      it { should == 'Jeremy' }
    end

    context '#api_key' do
      subject { @user.api_key }
      it { should == 'abc' }
    end
  end
end