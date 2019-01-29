module Support
  module MeetingHelper

    def book_meeting params
      calendar = page.find(:css, 'div#calendar')
      calendar.find(:css,".fc-day-grid  td[class='fc-day fc-widget-content fc-tue fc-today fc-state-highlight']").click
      i_fill_meeting_form(params)
    end

    def i_cancel_booking
      cancel_link = find("a", text: "Cancel", visible: false)
      scroll_to(cancel_link)
      cancel_link.click
      wait_for_ajax
      
    end

    def i_fill_meeting_form(params)
      within("form") do
        fill_in('meeting[name]', with: params[:name])
        fill_in('meeting[time_start]', with: params[:time_start])
        fill_in('meeting[time_end]', with: params[:time_end])
      end
      btn = find_button(value: 'Save', visible: false)
      scroll_to(btn)
      btn.click
      wait_for_ajax
    end

    def i_book_meeting_to_day_next_hour name
      meeting_date = DateTime.now
      time_start = (meeting_date + 1.hour).beginning_of_hour
      time_end = time_start + 30.minutes
      params = {name: name, time_start: time_start.strftime("%I:%M %p") , time_end: time_end.strftime("%I:%M %p")}
      book_meeting(params)
    end

    def i_book_meeting_to_day_in_the_past name
      meeting_date = DateTime.now
      time_start = meeting_date.beginning_of_hour
      time_end = time_start + 30.minutes
      params = {name: name, time_start: time_start.strftime("%I:%M %p") , time_end: time_end.strftime("%I:%M %p")}
      book_meeting(params)
    end

    def the_meeting_is_booked room_name, meeting_name
      table = page.find(:css, 'table')
      room_row = table.find(:xpath, "//tr[td[@class='room_uppercase']]")
      assert_selector(:xpath, "//tr[td[@class='room_uppercase']]", text: "Room: #{room_name.split.map(&:upcase_first).join(' ')}") 
      assert_selector(:xpath, "//tr[td]", text: meeting_name)
    end

    def the_meeting_cannot_be_created_in_the_past
      assert_selector(:xpath, "//ul[li]", text: 'Cannot save meeting from the past')
    end
    
    def the_meeting_time_is_not_available
      error = "Time is not available for this room for these dates [#{DateTime.now.to_date}]"
      assert_selector(:xpath, "//ul[li]", text: error)
    end
  end
end       