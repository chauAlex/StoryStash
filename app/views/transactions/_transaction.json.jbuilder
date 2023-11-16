json.extract! transaction, :id, :trans_id, :user_id, :article_id, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
