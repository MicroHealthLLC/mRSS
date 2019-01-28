module Support
  module RoomsHelper

    def i_go_to_rooms
      visit rooms_url
    end

    def i_go_to_new_room
      click_on 'New Room'
      wait_for_ajax
    end

    def i_create_room(room_params)
      i_fill_room_form(room_params)
    end

    def the_room_is_created(room_params)
      assert_selector "h2", text: room_params[:name].capitalize
    end

    def the_room_is_updated(new_name)
      assert_selector "h2", text: new_name
    end

    def i_update_the_room_name(name)
        fill_in('room[name]', with: name)
        find_button(value: 'Save').click
        wait_for_ajax
    end

    def i_go_to_edit_room
      click_on 'Edit Room'
      wait_for_ajax
    end

    def i_delete_room
      page.accept_confirm do
        click_on 'Delete'
      end
      wait_for_ajax
    end
    
    def i_fill_room_form(params)
      within("form") do
       fill_in('room[name]', with: params[:name])
       find_button(value: 'Save').click
      end
      wait_for_ajax
    end

   def the_rooms_page_has_one_room
    rows_equal_to 1
   end

   def the_rooms_page_has_two_rooms
    rows_equal_to 2
   end

   def i_go_to_room_from_table name
    table = page.find(:css, 'table#rooms_table')
    row = table.find(:xpath, "//tr[td='#{name}']")
    row.click
   end

   def rows_equal_to count
    table = page.find(:css, 'table#rooms_table')
    row_count = table.all(:css, 'tr').size
    assert_equal row_count, (count + 1)
   end

  end
end       