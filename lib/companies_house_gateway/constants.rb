module CompaniesHouseGateway
  module Constants
    # Check types suported by the Companies House XML Gateway
    SUPPORTED_REQUESTS = %w(NameSearch NumberSearch CompanyAppointments
                            CompanyDetails OfficerSearch OfficerDetails
                            Mortgages FilingHistory DocumentInfo Document)
  end
end