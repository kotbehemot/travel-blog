class Admin::BaseController < ApplicationController
  http_basic_authenticate_with :name => "user", :password => "secret"
end
