# frozen_string_literal: true

require 'test_helper'

class TestTrackerTimeEntries < Minitest::Test
  describe 'Tracker TimeEntries Requests' do
    client = PapierkramApi::Client.new('simonneutert')

    it 'raises an error on faulty billing_state params', :vcr do
      assert_raises ArgumentError do
        client.tracker_time_entries.all(billing_state: 'xxx')
      end
    end
    it 'raises an error on faulty order_direction params', :vcr do
      assert_raises ArgumentError do
        client.tracker_time_entries.all(order_direction: 'xxx')
      end
    end
  end
end
