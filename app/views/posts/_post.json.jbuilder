json.extract! post, :id, :name, :description, :group_id, :created_at, :updated_at
json.url group_posts_url(post, format: :json)
