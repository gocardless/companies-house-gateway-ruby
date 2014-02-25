module CompaniesHouseGateway
  module Constants
    # Check types suported by the Companies House XML Gateway
    SUPPORTED_REQUESTS = %w(NameSearch NumberSearch CompanyAppointments
                            CompanyDetails OfficerSearch OfficerDetails
                            Mortgages FilingHistory DocumentInfo Document)

    DATA_SETS = [
      "LIVE",      # Live companies and those dissolved in the last 12 months
      "DISSOLVED", # Companies that have been dissolved in the last 20 years
      "FORMER",    # All previous company names from the last 20 years
      "PROPOSED",  # Proposed changes to the names of existing companies
    ].freeze

    OFFICER_TYPES = [
      "DIS",       # Disqualified Directors only
      "LLP",       # Limited Liability Partnerships
      "CUR",       # Current (i.e., not above)
      "EUR",       # SE and ES appointments only
    ].freeze
  end
end