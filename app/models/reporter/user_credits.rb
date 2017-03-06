module Reporter
  class UserCredits < Reporter::Base
    class << self
      def report(user_id)
        credits = Credit.select('debts.*').where(pay_to_id: user_id)
        credits = join_credit_owners(credits)
        credits = join_apartments(credits)
        credits
      end

      def join_credit_owners(credits)
        credits.select('owners.id AS owner_id,
                        owners.first_name AS owner_first_name,
                        owners.last_name AS owner_last_name')
               .joins('LEFT JOIN users AS owners ON debts.user_id = owners.id')
      end

      def join_apartments(credits)
        credits.select('apartments.name AS apartment_name')
               .joins('LEFT JOIN apartments ON debts.apartment_id = apartments.id')
      end
    end
  end
end
