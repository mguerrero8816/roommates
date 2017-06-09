module SelectOptionsHelper
  def apartment_users_options_for_select(apartment_id)
    User.where('apartment_users.apartment_id = ?', apartment_id)
        .joins('LEFT JOIN apartment_users ON users.id = apartment_users.user_id')
        .order('users.last_name')
        .map{|user| ["#{user.first_name} #{user.last_name}", user.id]}
  end
end
