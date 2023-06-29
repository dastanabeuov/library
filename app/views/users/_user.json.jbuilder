json.extract! user, :id, :first_name, :last_name, :middle_name,
                    :position, :phone, :active, :role,
                    :email, :password, :group_id,
                    :created_at, :updated_at
json.url user_url(user, format: :json)
