module Reporter
  class Home
    class << self
      # takes: integer
      # returns: hash
      def apartments_bills(user_id)
        bills = Bill.where(user_id: user_id)
        bills = join_payments(bills)
        bills
      end

      private

      def join_payments(bills)
        bills.joins('payments ON bills.id = payments.debt_id')
      end
    end
  end
end
