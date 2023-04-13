# frozen_string_literal: true

require 'test_helper'

class TestProjects < Minitest::Test
  describe 'Project Requests' do
    it 'gets a project', :vcr do
      client = PapierkramApiClient::Client.new('simonneutert')
      response = client.projects.by(id: 5)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'get all projects', :vcr do
      client = PapierkramApiClient::Client.new('simonneutert')
      response = client.projects.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end
  end
end
