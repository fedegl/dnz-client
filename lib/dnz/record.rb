require 'nokogiri'
require 'dnz/memoizable'
require 'dnz/namespace_array'

module DNZ
  # This class is for fetching record metadata from DigitalNZ.
  #
  # Example:
  #
  #   DNZ::Client.connect('xxx', 'v2')
  #   search = DNZ::Client.search('Kahikatea')
  #   id = search.results.first.id
  #   record = DNZ::Record.find(id)
  #   puts record.dc.title.text => "Kahikatea Kainga"
  #
  # The record's namespaces can be enumerated:
  #
  #   record.namespaces => ['dc', 'dnz']
  #
  # And each attribute can be enumerated:
  #
  #   record.dc.names => ['title', 'identifier', ...]
  #
  class Record
    # Find a record by ID using the default client connection (see Client::connect).
    def self.find(id)
      self.new(Client.connection, id)
    end

    attr_reader :id

    # Find a record by ID using the specified Client.
    def initialize(client, id)
      @client = client
      @id = id

      options = {:id => @id}
      @xml = @client.fetch(:record, options)
      parse_record
    end

    def type
      @data['type']
    end

    def method_missing(method, * args, & block)
      if attribute = document.root.attributes[method.to_s.upcase]
        attribute.to_s
      else
        @data.send(method, * args, & block)
      end
    end

    # Fetch the availability information from the API
    def availability
      @availability ||= begin
        xml = @client.fetch(:record_availability, :id => self.id)
        doc = Nokogiri::XML(xml)

        returning({}) do |hash|
          doc.xpath('//holding').each do |xdata|
            holding = xdata.xpath('name').text
            hash[holding] = xdata.xpath('available').text == 'true'
          end
        end
      end
    end

    private

    # Return a Nokogiri document for the XML
    def document
      @doc ||= Nokogiri::XML(@xml)
    end

    # Parse the result into an array of DNZ::Result
    def parse_record
      @data = NamespaceArray.new
      document.xpath('//xmlns:xmlData').each do |xdata|
        xdata.children.each do |child|
          if child.element?
            @data << child
          end
        end
      end
    end
  end
end