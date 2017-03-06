module Reporter
  class UserCredits < Reporter::Base
    class << self
      def report(user_id)
        credits = Credit.where(pay_to_id: user_id)
        credits
      end
    end
  end
end
