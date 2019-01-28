module Support
  module UserSharedContext 
    def setup
      @admin = users(:admin)
    end

    def teardown
      sign_out @admin
    end

    def sign_in_as_admin
      user_sign_in @admin.login, '12345678As'
      
    end

    def user_is_signed_in
      assert_equal true, page.has_current_path?('/')
    end

    def user_sign_in login, password
        visit new_user_session_url

        fill_in("user[login]", with: login)
        fill_in("user[password]", with: password)

        click_on "Sign in"

        wait_for_ajax

    end
    end
end       