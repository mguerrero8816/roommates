module Reporter
  class Roommates < Reporter::Base
    class << self
      def report(user_id)
        users = ApartmentTenant.where(user_id: user_id)
        users = join_apartments(users)
        users = join_roommates(users)
        roommates = build_roommates_table(users)
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

      def build_roommates_table(users)
        table = []
        users.each do |user|
          { user: user, debts: query_debts(user.id), credits: query_credits(user.id) }
        end
        table
      end

      def query_debts(user_id)
        []
      end

      def query_credits(user_id)
        []
      end
    end
  end
end
