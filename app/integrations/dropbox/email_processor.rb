module Dropbox
  class EmailProcessor

    attr_reader :email, :label

    def initialize(email, label)
      @email = email
      @label = label
    end

    def run
      return false if email.labels.include?(label_read) or !email.subject.include?('na-pi')
      puts "Processing email #{email.subject}"

      #puts email.body.to_s
      coords = /Latitude:(?<lat>[0-9\.]+).+Longitude:(?<lon>[0-9\.]+)/m.match email.body.to_s
      puts coords
      if coords && coords[:lat] && coords[:lon]
        puts coords[:lat]
        puts coords[:lon]
        Location.create!(:lat => coords[:lat].to_f, :lon => coords[:lon].to_f, :emailed_at => email.date)
      end
      email.move_to!(label_read, label)
    end

    private
    def label_read
      "#{@label}_read"
    end
  end
end