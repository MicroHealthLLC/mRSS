require "application_system_test_case"

class MeetingsTest < ApplicationSystemTestCase
  test 'Creating meeting in the past' do
    room_a_params = {name: 'New room'} 
    sign_in_as_admin
    user_is_signed_in
    i_go_to_rooms
    i_go_to_new_room
    i_create_room(room_a_params)
    the_room_is_created(room_a_params)
    i_book_meeting_to_day_next_hour('New meeting')
    i_go_to_meetings
    the_meeting_is_booked('New room', 'New meeting')
    i_go_to_rooms
    i_go_to_room_from_table(room_a_params[:name])
    i_book_meeting_to_day_in_the_past('Past meeting')
    the_meeting_cannot_be_created_in_the_past
    i_cancel_booking
    i_book_meeting_to_day_next_hour('Other meeting')
    the_meeting_time_is_not_available([Date.today])
  end
  
  
end
