module Reporter
  class UserCredits < Reporter::Base
    class << self
      def report(user_id)
        credits = Credit.select('debts.*').where(pay_to_id: user_id)
        credits = join_credit_payers(credits)
        credits = join_apartments(credits)
        credits
      end

      private

      def join_credit_payers(credits)
        credits.select('payers.id AS payer_id,
                        payers.first_name AS payer_first_name,
                        payers.last_name AS payer_last_name')
               .joins('LEFT JOIN users AS payers ON debts.user_id = payers.id')
      end

      def join_apartments(credits)
        credits.select('apartments.name AS apartment_name')
               .joins('LEFT JOIN apartments ON debts.apartment_id = apartments.id')
      end
    end
  end
end
