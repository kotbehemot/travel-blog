json.array!(@settings) do |setting|
  json.extract! setting, :id, :key, :setting_value
end
