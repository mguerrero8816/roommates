class HomeReporter
  class << self
    # takes: integer
    # returns: hash
    def apartments_bills(user_id)
      tenant = ApartmentTenant.where(user_id: user_id )
      apartments = Apartment.where(id: tenant.map(&:apartment_id))
      report = create_apartment_segments(apartments)
      bills = Bill.where(apartment_id: apartments.map(&:id))
      populate_report_with_bills(report, bills)
      report
    end

    # takes: collection of apartments
    # returns: hash
    def create_apartment_segments(apartments)
      report = {}
      apartments.each do |apartment|
        apartment_key = apartment.id.to_s.to_sym
        report[apartment_key] = { apartment: apartment }
      end
      report
    end

    def populate_report_with_bills(report, bills)
      bills.each do |bill|
        apartment_key = bill.apartment_id.to_s.to_sym
        report[apartment_key][:bill] = bill
      end
      report
    end
  end
end
