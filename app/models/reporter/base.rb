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
        payments = Payment.where(payable_id: bill_ids, payable_type: 'Debt', active: true)
        payment_data = {}
        payments.each do |payment|
          bill_key = payment.payable_id.to_s.to_sym
          payment_data[bill_key] = 0 if payment_data[bill_key].nil?
          payment_data[bill_key] += payment.cents
        end
        objects.each do |object|
          object.class_eval { attr_accessor :amount_paid }
          object.amount_paid = 0
          bill_key = object.bill_id.to_s.to_sym
          next if object.bill_id.nil? || payment_data[bill_key].nil?
          object.amount_paid = payment_data[bill_key]
        end
        objects
      end
    end
  end
end
