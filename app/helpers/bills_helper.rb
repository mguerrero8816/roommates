module BillsHelper
  def generateSplitOptions(special_split)
    users_data = {}
    User.select('id, first_name, last_name').where(id: special_split.keys).each do |user|
      id_key = user.id.to_s
      users_data[id_key] = user
    end
    content_tag(:div, id: 'special-split-form') do
      if special_split.present?
        concat(content_tag(:table) do
          concat(content_tag(:tbody) do
            special_split.each do |split_user_id, amounts|
              concat(content_tag(:tr) do
                concat(content_tag(:td, users_data[split_user_id].full_name))
                concat(content_tag(:td) do
                  concat(content_tag(:input, '', min: 0, class: 'split-dollars split-value', name: "special_split[#{split_user_id}][dollars]", type: 'number', readonly: '', value: amounts[:dollars], data: { lock: split_user_id }))
                  concat(content_tag(:span, '.'))
                  concat(content_tag(:input, '', min: 0, max: 99, class: 'split-cents split-value', name: "special_split[#{split_user_id}][cents]", type: 'number', value: amounts[:cents], readonly: '', data: { lock: split_user_id }))
                end)
                concat(content_tag(:td) do
                  concat(content_tag(:input, '', class: 'split-lock', id: "split_lock_#{split_user_id}", type: 'checkbox', checked: '', data: { lock: split_user_id }))
                  concat(content_tag(:label, 'Lock', for: "split_lock_#{split_user_id}", data: { lock: split_user_id }))
                end)
              end)
            end
          end)
        end)
      end
    end
  end

  def generateSplitToggle(special_set)
    if special_set
      even_class = 'fake-link'
      special_class = ''
    else
      even_class = ''
      special_class = 'fake-link'
    end
    content_tag(:span) do
      concat(content_tag(:span, 'Even', id: 'set-even', class: even_class))
      concat(content_tag(:span, ' | '))
      concat(content_tag(:span, 'Special', id: 'set-special', class: special_class))
    end
  end
end
