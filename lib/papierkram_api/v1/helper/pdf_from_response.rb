# frozen_string_literal: true

module PapierkramApi
  module V1
    module Helper
      # This class is responsible to convert a response to a pdf file.
      class PdfFromResponse
        def initialize(response)
          @response = response
        end

        def to_pdf(filename = Time.now.to_s)
          raise ArgumentError, 'Response is not a Faraday::Response' unless @response.is_a?(Faraday::Response)
          raise ArgumentError, 'Response is not a PDF file' unless response.body.start_with?('%PDF-1.4')

          file = Tempfile.new([filename.to_s, '.pdf'], binmode: true)
          file.write(response.body)
          file.close

          { response: @response, path_to_pdf_file: file.path }
        end
      end
    end
  end
end
