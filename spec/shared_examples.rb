shared_examples 'it validates presence' do |property|
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  subject(:perform_check) { described_class.new(client).perform(check_data) }

  context "with a missing #{property}" do
    before { check_data.delete(property) }

    it "raises and error" do
      expect { perform_check }.
        to raise_error CompaniesHouseGateway::InvalidRequestError
    end
  end
end

shared_examples 'it generates valid xml' do
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
    fixture_path('check_schemas',
                 "#{CompaniesHouseGateway::Util.underscore(klass)}.xsd")
  end
  let(:xsd_doc) { Nokogiri::XML(File.read(xsd_path), xsd_path) }
  let(:xsd) { Nokogiri::XML::Schema.from_document(xsd_doc) }

  it "generates a valid XML request" do
    expect(xsd.validate(request_xml)).to eq([])
  end
end

shared_examples 'it returns only the body of the response' do
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  let(:klass) { described_class.name.split("::").last }
  let(:response) { { status: 200, body: body } }
  let(:body) do
    load_fixture('check_responses',
                 "#{CompaniesHouseGateway::Util.underscore(klass)}.xml")
  end
  before { stub_request(:post, config[:api_endpoint]).to_return(response) }
  subject { described_class.new(client).perform(check_data) }

  it { is_expected.to be_a Hash }
  it { is_expected.not_to be_empty }
  it { is_expected.not_to include klass }
end