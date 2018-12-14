class ApplicationController < ActionController::Base
  protection_from_forgery with::exception

  def hello
    render html: "hello, world!"
  end
end
