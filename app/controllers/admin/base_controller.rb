class Admin::BaseController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USERNAME"] || "user", :password => ENV["ADMIN_PASSWORD"] || "secret"

  layout 'admin'
end
