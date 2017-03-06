module Reporter
  class Base
    class << self
      def join_bill_payers(objects)
        objects.select('payers.id AS payer_id,
                        payers.first_name AS payer_first_name,
                        payers.last_name AS payer_last_name')
               .joins('LEFT JOIN users AS payers ON bills.user_id = payers.id')
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
