# YOUR CREDENTIALS
username = "your_user_name"
password = "your_password"

shared_context "Log In" do
  before do
    if username == "your_user_name"
      raise "PLEASE GO TO SPEC/HELPERS/LOG_IN.RB AND ENTER YOUR CREDENTIALS"
    end
    visit "http://www.okcupid.com"
    expect(page).to have_text "Sign in"
    click_link "Sign in"
    expect(page).to have_text "Forgot your password"
    fill_in "login_username", with: username
    fill_in "login_password", with: password
    click_button 'Let’s go'
    expect(page).to have_text "Browse Matches"
  end
end
