# frozen_string_literal: true

require 'test_helper'

class TestTrackerTimeEntries < Minitest::Test
  describe 'Tracker TimeEntries Requests' do
    it 'gets a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.by(id: 1)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'get all tracker time_entries', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end
  end
end
