shared_examples 'it validates presence' do |property|
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  subject(:perform_check) { described_class.new(client).perform(check_data) }

  context "with a missing #{property}" do
    before { check_data.delete(property) }

    it "raises and error" do
      expect { perform_check }.
        to raise_error CompaniesHouseGateway::CompaniesHouseGatewayError
    end
  end
end

shared_examples 'it generates_valid_xml' do
  let(:request) { CompaniesHouseGateway::Request.new(connection, config) }
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  let(:connection) { client.send(:connection) }
  let(:klass) { described_class.name.split("::").last }

  let(:request_xml) do
    builder = Nokogiri::XML::Builder.new do |xml|
      request.send(:request_body, xml, klass, check_data)
    end
    builder.doc
  end

  let(:xsd_path) do
    fixture_path('checks',
                 "#{CompaniesHouseGateway::Util.underscore(klass)}.xsd")
  end
  let(:xsd_doc) { Nokogiri::XML(File.read(xsd_path), xsd_path) }
  let(:xsd) { Nokogiri::XML::Schema.from_document(xsd_doc) }

  it "generates a valid XML request" do
    xsd.validate(request_xml).should == []
  end
end