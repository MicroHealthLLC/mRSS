require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  test 'creating room' do
    room_a_params = {name: 'Room a'}
    room_b_params = {name: 'Room b'}
    
    sign_in_as_admin
    user_is_signed_in
    i_go_to_rooms
    
    i_go_to_new_room
    i_create_room(room_a_params)
    the_room_is_created(room_a_params)
    i_go_to_edit_room
    i_update_the_room_name('New room')
    the_room_is_updated('New room')
    i_go_to_rooms
    the_rooms_page_has_one_room
    i_go_to_new_room
    i_create_room(room_b_params)
    the_room_is_created(room_b_params) 
    i_go_to_rooms
    the_rooms_page_has_two_rooms
    i_go_to_room_from_table(room_b_params[:name])
    i_go_to_edit_room
    i_delete_room
    the_rooms_page_has_one_room

  end
  
  
end
