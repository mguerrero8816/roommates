module Reporter
  class Base
    class << self
      def join_bill_owners(objects)
        objects.select('owners.id AS owner_id,
                        owners.first_name AS owner_first_name,
                        owners.last_name AS owner_last_name')
               .joins('LEFT JOIN users AS owners ON bills.user_id = owners.id')
      end

      def add_bill_payments(objects)
        bill_ids = objects.map(&:bill_id)
        payments = Payment.where(debt_id: bill_ids, active: true)
        objects.each do |row|
          row.amount_paid = 0
          next if row.bill_id.nil?
          payments.each do |payment|
            next if payment.debt_id.nil?
            if payment.debt_id == row.bill_id
              row.amount_paid += payment.cents
            end
          end
        end
      end
    end
  end
end
