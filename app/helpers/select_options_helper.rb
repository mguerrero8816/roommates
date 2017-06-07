module SelectOptionsHelper
  def apartment_tenants_options_for_select(apartment_id)
    User.where('apartment_tenants.apartment_id = ?', apartment_id)
        .joins('LEFT JOIN apartment_tenants ON users.id = apartment_tenants.user_id')
        .order('users.last_name')
        .map{|user| ["#{user.first_name} #{user.last_name}", user.id]}
  end
end
