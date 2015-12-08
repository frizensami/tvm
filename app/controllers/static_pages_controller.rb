require 'digest'
class StaticPagesController < ApplicationController
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == 'c8bad41e1002c9972696a22dc4ee3681'
    end
  end

  def home
  end

  def overview
  end

  def about
  end
end
