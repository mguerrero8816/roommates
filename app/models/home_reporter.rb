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
      collect_owners_from_bills(report)
      owners = User.where(id: bills.map(&:user_id))
      populate_report_with_owners(report, owners)
      report
    end

    # takes: collection of apartments
    # returns: hash
    def create_apartment_segments(apartments)
      report = {}
      apartments.each do |apartment|
        apartment_key = apartment.id.to_s.to_sym
        report[apartment_key] = { apartment: apartment, bills: {}, bill_owner_ids: [], bill_owners: {} }
      end
      report
    end

    def populate_report_with_bills(report, bills)
      bills.each do |bill|
        apartment_key = bill.apartment_id.to_s.to_sym
        bill_key = bill.id.to_s.to_sym
        report[apartment_key][:bills][bill_key] = bill
      end
      report
    end

    def collect_owners_from_bills(report)
      report.each do |_, row|
        row[:bills].each do |_, bill|
          row[:bill_owner_ids] << bill.user_id
        end
      end
      report
    end

    def populate_report_with_owners(report, owners)
      report.each do |_, row|
        owners.each do |owner|
          if row[:bill_owner_ids].include?(owner.id)
            owner_key = owner.id.to_s.to_sym
            row[:bill_owners][owner_key] = owner
          end
        end
      end
      report
    end
  end
end
