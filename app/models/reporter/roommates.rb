module Reporter
  class Roommates < Reporter::Base
    class << self
      def report(user_id)
        users = ApartmentTenant.where(user_id: user_id)
        users = join_apartments(users)
        users = join_roommates(users)
        roommates = build_roommates_table(users, user_id)
        roommates
      end

      private

      def join_apartments(users)
        users.select('apartments.name AS apartment_name')
             .joins('LEFT JOIN apartments ON apartment_tenants.apartment_id = apartments.id')
      end

      def join_roommates(users)
        users.select('roommates.id AS roommate_id,
                      roommates.first_name AS roommate_first_name,
                      roommates.last_name AS roommate_last_name')
             .joins('LEFT JOIN apartment_tenants AS tenants ON apartments.id = tenants.apartment_id')
             .joins('LEFT JOIN users AS roommates ON tenants.user_id = roommates.id')
      end

      def build_roommates_table(users, user_id)
        table = []
        users.each do |user|
          next if user.roommate_id == user_id
          table << { user: user, lends: query_credits(user_id, user.roommate_id), owes: query_credits(user.roommate_id, user_id) }
        end
        table
      end

      def query_credits(pay_to_id, user_id)
        credits = Credit.select('debts.*').where(pay_to_id: pay_to_id, user_id: user_id)
        credits = join_credit_apartments(credits)
        credits
      end

      def join_credit_apartments(credits)
        credits.select('apartments.name AS apartment_name')
               .joins('LEFT JOIN apartments ON debts.apartment_id = apartments.id')
      end
    end
  end
end
