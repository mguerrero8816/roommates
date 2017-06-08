module Reporter
  class ApartmentsBills < Reporter::Base
    class << self
      # takes: integer
      # returns: hash
      def report(user_id)
        apartments = ApartmentUser.select('apartment_users.id').where(user_id: user_id)
        apartments = join_apartments(apartments)
        apartments = join_bills(apartments)
        apartments = join_bill_payers(apartments)
        apartments = add_bill_payments(apartments)
        apartments
      end

      private

      def join_apartments(apartments)
        apartments.select('apartments.id AS apartment_id,
                           apartments.name AS apartment_name')
                  .joins('LEFT JOIN apartments ON apartment_users.apartment_id = apartments.id')
      end

      def join_bills(apartments)
        apartments.select('bills.id AS bill_id,
                           bills.name AS bill_name,
                           bills.cents AS bill_cents,
                           bills.due AS bill_due')
                  .joins("LEFT JOIN debts AS bills ON apartments.id = bills.apartment_id and bills.type = 'Bill' ")
      end
    end
  end
end
