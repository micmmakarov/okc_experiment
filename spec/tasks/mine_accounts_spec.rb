require "rails_helper"
require 'helpers/log_in'

leads = []

describe "getting leads" do
  include_context 'Log In'
  it "scrolls and grabs leads", js: true do
     click_link "Browse Matches"
     startedTime = DateTime.now
     10.times do |i|
       5.times do |scroll|
         puts "#{50 - i * 5 - scroll} iterations left..."
         page.execute_script "window.scrollBy(0,100000)"
         sleep 0.2
         page.execute_script "window.scrollBy(0,0)"
         sleep 0.2
       end
       names = all(".username a")
       if names.any?
         names.each do |n|
           begin
             leads << n.text if n && n.text
           rescue => e
            puts "Error: #{e.message}"
           end
         end
       end
    end
     leads.uniq!
     finishedTime = DateTime.now
     leads.each do |u|
       unless Lead.where(name: u).any?
         Lead.create(name: u)
       end
     end
     leads.length.should > 1
     puts "Success, grabbed #{leads.length} okcupid handles"
  end
end
