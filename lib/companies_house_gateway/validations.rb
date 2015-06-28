module CompaniesHouseGateway
  module Validations

    VALIDATIONS = {
      company_name:           ->(value) { clean_string(value, :company_name) },
      company_number:         ->(value) { clean_company_number(value) },
      partial_company_number: ->(value) { value },
      give_mort_totals:       ->(value) { clean_boolean(value, :give_mort_totals) },
      search_rows:            ->(value) { clean_number(value, :search_rows) },
      data_set:               ->(value) { clean_data_set(value) },
      capital_doc_ind:        ->(value) { clean_boolean(value, :capital_doc_ind) },
      include_resigned_ind:   ->(value) { clean_boolean(value, :include_resigned_ind) },
      satisfied_charges_ind:  ->(value) { clean_boolean(value, :satisfied_charges_ind) },
      start_date:             ->(value) { clean_date(value, :start_date) },
      end_date:               ->(value) { clean_date(value, :end_date) },
      surname:                ->(value) { clean_string(value, :surname) },
      forename:               ->(value) { clean_string(value, :forename) },
      post_town:              ->(value) { clean_string(value, :post_town) },
      officer_type:           ->(value) { clean_officer_type(value) },
    }

    def self.clean_param(key, value)
      validator = VALIDATIONS.fetch(key, ->(value){ value })
      validator.call(value)
    end

    def self.clean_string(string, param)
      return unless string
      input_error(param, string) unless string =~ /\A.{0,160}\z/
      string
    end

    def self.clean_date(date, param)
      return unless date
      date = Date.parse(date) if date.is_a? String
      date.strftime("%d/%m/%Y")
    rescue
      input_error(param, date)
    end

    def self.clean_boolean(bool, param)
      return unless bool
      input_error(param, bool) unless [true, false].include?(bool)
      bool
    end

    def self.clean_number(value, param)
      return unless value
      input_error(param, value) unless value.to_s =~ /\A\d+\z/
      value.to_s
    end

    def self.clean_data_set(value)
      return unless value
      value = value.to_s.upcase
      input_error(:data_set, value) unless Constants::DATA_SETS.include?(value)
      value
    end

    def self.clean_officer_type(type)
      return unless type
      type = type.to_s.upcase
      unless Constants::OFFICER_TYPES.include?(type)
        input_error(:officer_type, type)
      end
      type
    end

    def self.clean_company_number(number)
      return unless number
      number = number.to_s.strip # remove whitespace
      number = number.upcase # upcase any prefixes

      # 0-pad 5 or 7 digit registration number
      if number.match /\A(\D{2})(\d{5})\z/
        number = $1 + $2.rjust(6,"0")
      elsif number.match /\A\d{7}\z/
        number = number.rjust(8, "0")
      end

      companies_house_regex = /\A(#{Constants::ALLOWED_PREFIXES * '|'})\d{6}\z/
      if number =~ companies_house_regex
        number
      else
        input_error(:company_number, number)
      end
    end

    def self.input_error(param, value=nil)
      msg = if value.nil?
        "#{param} is a required param"
      else
        %{Invalid value "#{value}" for #{param}}
      end
      raise InvalidRequestError.new(msg, param)
    end
  end
end
