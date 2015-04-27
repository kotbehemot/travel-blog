module SpotDropbox
  class EmailProcessor

    attr_reader :email

    def initialize(email)
      @email = email
    end

    def run
      message_body = email.attr['BODY[TEXT]']
      message_date = email.attr['INTERNALDATE']
      coords = /Latitude:(?<lat>[0-9\.]+).+Longitude:(?<lon>[0-9\.]+)/m.match message_body
      if coords && coords[:lat] && coords[:lon]
        puts coords[:lat]
        puts coords[:lon]
        puts "Adding location: [#{coords[:lat]}, #{coords[:lon]}]"
        Location.create!(:lat => coords[:lat].to_f, :lon => coords[:lon].to_f, :emailed_at => message_date) unless Location.where(:emailed_at => message_date).exists?
      end
    end
  end
end