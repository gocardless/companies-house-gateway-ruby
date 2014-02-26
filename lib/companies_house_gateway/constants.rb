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

    # White list of allowed prefixes for companies house numbers.
    # 1st line is English and Welsh prefixes
    # 2nd line is Scottish prefixes
    # 3rd line is Northen Irish prefixes
    # \d\d is the default prefix in regex notation.
    ALLOWED_PREFIXES = %w(AC BR FC GE IP LP OC RC SE ZC
                          SC SA SF SL SZ SP SO SR
                          NI NA NF NL NZ NP NO NR
                          \d\d)
  end
end