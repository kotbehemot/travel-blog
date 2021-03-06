Rails.application.config.middleware.insert_before(::Rack::Runtime, ::Rack::Rewrite) do
  r301 %r{.*}, "#{ENV["CANONICAL_HOST"]}$&", :if => Proc.new {|rack_env|
    Regexp.new(rack_env['SERVER_NAME']).match(ENV["CANONICAL_HOST"]).nil?
  }
end if Rails.env == 'production' && ENV["CANONICAL_HOST"]