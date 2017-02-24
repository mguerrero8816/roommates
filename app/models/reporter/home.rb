module Reporter
  class Home
    class << self
      # takes: integer
      # returns: hash
      def apartments_bills(user_id)
        apartments = ApartmentTenant.select('apartment_tenants.id').where(user_id: user_id)
        apartments = join_users_and_apartments(apartments)
        apartments
      end

      private

      def join_users_and_apartments(apartments)
        apartments.joins('LEFT JOIN users ON apartment_tenants.user_id = users.id')
                  .joins('LEFT JOIN apartments ON apartment_tenants.apartment_id = apartments.id')
      end

      def join_payments(bills)
        bills.joins('payments ON bills.id = payments.debt_id')
      end
    end
  end
end
