require 'gmail'

module Dropbox
  class SpotScanner

    def self.process!
      puts "Connecting to gmail folder: #{gmail_credentials[:label]}"
      Gmail.connect!(gmail_credentials[:username], gmail_credentials[:password]) do |client|
        spot_folder_emails = client.mailbox(gmail_credentials[:label]).emails(:before => (Date.today - 2.days))
        puts "Folder size: #{spot_folder_emails.size}"
        spot_folder_emails.each do |email|
          Dropbox::EmailProcessor.new(email, gmail_credentials[:label]).run
        end
      end
    end

    private
    def self.gmail_credentials
      @gmail_credentials ||= {
        :username => ENV["SPOT_GMAIL_USERNAME"] || 'gmail',
        :password => ENV["SPOT_GMAIL_PASSWORD"] || 'pass',
        :label => ENV["SPOT_GMAIL_LABEL"] || 'SPOT'
      }
    end

  end
end
