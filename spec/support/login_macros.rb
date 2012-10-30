module LoginMacros

  def sign_in(user)
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end
end

RSpec.configure do |config|
  config.include LoginMacros, :type => :request
end