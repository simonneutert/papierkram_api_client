# frozen_string_literal: true

require 'test_helper'

class TestTrackerTimeEntries < Minitest::Test
  describe 'Tracker::TimeEntries Requests' do
    it 'gets a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.find_by(id: 1)
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

    it 'creates a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.create(
        entry_date: '2020-05-11',
        started_at_time: '10:00',
        ended_at_time: '12:00',
        task_id: 3,
        user_id: 3,
        comments: 'Worked hard',
        unbillable: false
      )

      assert_equal(201, response.status)
      refute_empty(response.body)
    end

    it 'updates a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.update_by(
        id: 3,
        comments: 'Worked very hard'
      )

      assert_equal(200, response.status)
      refute_empty(response.body)
    end

    it 'archives a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.archive_by(id: 3)

      assert_equal(200, response.status)
      refute_empty(response.body)
    end

    it 'unarchives a tracker time_entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_time_entries.unarchive_by(id: 3)

      assert_equal(200, response.status)
      refute_empty(response.body)
    end
  end
end
