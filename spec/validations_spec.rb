require 'spec_helper'

describe CompaniesHouseGateway::Validations do
  describe '#clean_string' do
    subject { CompaniesHouseGateway::Validations.clean_string(string, :param) }

    context "without a string" do
      let(:string) { nil }
      it { should == nil }
    end

    context "with a short string" do
      let(:string) { "A" * 160 }
      it { should == string }
    end

    context "with a long string" do
      let(:string) { "A" * 161 }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end

  describe '#clean_date' do
    subject { CompaniesHouseGateway::Validations.clean_date(date, :param) }

    context "without a date" do
      let(:date) { nil }
      it { should == nil }
    end

    context "with a date object" do
      let(:date) { Date.parse("01/01/2000") }
      it { should == date.strftime("%d/%m/%Y") }
    end

    context "with a parseable string" do
      let(:date) { "01-01-2000" }
      it { should == "01/01/2000" }
    end

    context "with a load of rubbish" do
      let(:date) { "A couple of weeks ago" }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end

  describe '#clean_boolean' do
    subject { CompaniesHouseGateway::Validations.clean_boolean(bool, :param) }

    context "without a boolean" do
      let(:bool) { nil }
      it { should == nil }
    end

    context "with a boolean" do
      let(:bool) { true }
      it { should == bool }
    end

    context "with a load of rubbish" do
      let(:bool) { "Sometimes" }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end

  describe '#clean_number' do
    subject { CompaniesHouseGateway::Validations.clean_number(number, :param) }

    context "without a number" do
      let(:number) { nil }
      it { should == nil }
    end

    context "with a number" do
      let(:number) { 9 }
      it { should == number.to_s }
    end

    context "with a string that looks like a number" do
      let(:number) { "91" }
      it { should == number }
    end

    context "with a load of rubbish" do
      let(:number) { "Ninety five" }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end

  describe '#clean_data_set' do
    subject { CompaniesHouseGateway::Validations.clean_data_set(data_set) }

    context "without a data_set" do
      let(:data_set) { nil }
      it { should == nil }
    end

    context "with a valid symbol" do
      let(:data_set) { :live }
      it { should == "LIVE" }
    end

    context "with a valid string" do
      let(:data_set) { "LIVE" }
      it { should == "LIVE" }
    end

    context "with a load of rubbish" do
      let(:data_set) { "ALL THE DATAS!!" }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end

  describe '#clean_officer_type' do
    subject do
      CompaniesHouseGateway::Validations.clean_officer_type(officer_type)
    end

    context "without an officer_type" do
      let(:officer_type) { nil }
      it { should == nil }
    end

    context "with a valid symbol" do
      let(:officer_type) { :dis }
      it { should == "DIS" }
    end

    context "with a valid string" do
      let(:officer_type) { "DIS" }
      it { should == "DIS" }
    end

    context "with a load of rubbish" do
      let(:officer_type) { "ALL THE DATAS!!" }
      it "raises an error" do
        expect { subject }.
          to raise_error CompaniesHouseGateway::InvalidRequestError
      end
    end
  end
end
