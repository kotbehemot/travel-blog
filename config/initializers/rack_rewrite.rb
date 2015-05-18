Rails.application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  r301 %r{.*}, "#{ENV["CANONICAL_HOST"]}$&", :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != ENV["CANONICAL_HOST"]
  }
end if Rails.env == 'production' && ENV["CANONICAL_HOST"]