require 'nokogiri'
require 'dnz/memoizable'
require 'dnz/namespace_array'

module DNZ
  class Record
    def self.find(id)
      self.new(Client.connection, id)
    end


    def initialize(client, id)
      @client = client
      options = {:id => id}

      @xml = @client.fetch(:record, options)
      parse_record
    end


    def method_missing(method, *args, &block)
      if attribute = document.root.attributes[method.to_s.upcase]
        attribute.to_s
      else
        @data.send(method, *args, &block)
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