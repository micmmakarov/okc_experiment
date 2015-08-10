
require "rails_helper"
require 'helpers/log_in'

# AB test?

messages = ['Hi, you look nice, would you like to get a drink?',
            'Hi... Your profile is fun, would you like to get a drink?']

leads = Lead.where(approached_at: nil)

describe "sending messages to unapproached leads" do
  include_context 'Log In'

  it "plays a numbers game", js: true do
    puts "Sending text to #{leads.count} leads"
    leads.each do |lead|
      visit "http://www.okcupid.com/profile/#{lead.name}"
      click_link "Send a Message"
      sleep 0.4
      ta = all("textarea")
      unless ta.any? # website is being slow???
         sleep 0.8
         ta = all("textarea")
      end
      if ta.any?
         id = ta[0][:id]
         message = messages.sample
         fill_in id, with: message
         click_button "Send"
         sleep 0.3
         #expect(page).to have_text "Message sent"
         puts "Message '#{message}' was sent to #{lead.name}"
         lead.message = message
         lead.approached_at = DateTime.now
         lead.save!
       end
    end
  end
end
