desc "Scans the desired Gmail inbox folder and imports SPOT standard emails creating map Locations"
task :spot_scanner => :environment do
  puts "[#{Time.now}] Scanning gmail account..."
  SpotDropbox::Scanner.process!
  puts "[#{Time.now}] done."
end