module Reporter
  class UserCredits < Reporter::Base
    class << self
      def report(user_id)
        credits = Credit.select('*').where(pay_to_id: user_id)
        credits = join_credit_owners(credits)
        credits
      end

      def join_credit_owners(credits)
        credits.select('owners.id AS owner_id,
                        owners.first_name AS owner_first_name,
                        owners.last_name AS owner_last_name')
               .joins('LEFT JOIN users AS owners ON debts.user_id = owners.id')
      end
    end
  end
end
