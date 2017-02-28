module Reporter
  class Home
    class << self
      # takes: integer
      # returns: hash
      def apartments_bills(user_id)
        apartments = ApartmentTenant.select('apartment_tenants.id').where(user_id: user_id)
        apartments = join_apartments(apartments)
        apartments = join_bills(apartments)
        apartments = join_bill_owners(apartments)
        apartments = add_bill_payments(apartments)
        apartments
      end

      private

      def join_apartments(apartments)
        apartments.select('apartments.id AS apartment_id,
                           apartments.name AS apartment_name')
                  .joins('LEFT JOIN apartments ON apartment_tenants.apartment_id = apartments.id')
      end

      def join_bills(apartments)
        apartments.select('bills.id AS bill_id,
                           bills.name AS bill_name,
                           bills.cents AS bill_cents,
                           bills.due AS bill_due')
                  .joins("LEFT JOIN debts AS bills ON apartments.id = bills.apartment_id and bills.type = 'Bill' ")
      end

      def join_bill_owners(apartments)
        apartments.select('owners.id AS owner_id,
                           owners.first_name AS owner_first_name,
                           owners.last_name AS owner_last_name')
                  .joins('LEFT JOIN users AS owners ON bills.user_id = owners.id')
      end

      def add_bill_payments(apartments)
        bill_ids = apartments.map(&:bill_id)
        payments = Payment.where(debt_id: bill_ids)
        apartments.each do |row|
          row.amount_paid = 0
          next if row.bill_id.nil?
          payments.each do |payment|
            next if payment.debt_id.nil?
            if payment.debt_id == row.bill_id
              row.amount_paid += payment.cents
            end
          end
        end
      end
    end
  end
end
