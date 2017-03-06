module Reporter
  class UserDebts < Reporter::Base
    class << self
      def report(user_id)
        debts = Credit.select('debts.*').where(user_id: user_id)
        debts = join_debt_owners(debts)
        debts = join_apartments(debts)
        debts
      end

      private

      def join_debt_owners(debts)
        debts.select('owners.id AS owner_id,
                      owners.first_name AS owner_first_name,
                      owners.last_name AS owner_last_name')
               .joins('LEFT JOIN users AS owners ON debts.pay_to_id = owners.id')
      end

      def join_apartments(debts)
        debts.select('apartments.name AS apartment_name')
             .joins('LEFT JOIN apartments ON debts.apartment_id = apartments.id')
      end
    end
  end
end
