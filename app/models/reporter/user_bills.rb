module Reporter
  class UserBills < Reporter::Base
    class << self
      def report(user_id)
        bills = User.where(id: user_id)
        bills = join_bills(bills)
        bills = join_bill_owners(bills)
        bills = add_bill_payments(bills)
        bills
      end

      def join_bills(bills)
        bills.select('bills.id AS bill_id,
                      bills.name AS bill_name,
                      bills.cents AS bill_cents,
                      bills.due AS bill_due')
             .joins("LEFT JOIN debts AS bills ON users.id = bills.user_id AND bills.type = 'Bill' ")
      end
    end
  end
end
