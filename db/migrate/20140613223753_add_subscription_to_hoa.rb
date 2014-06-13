class AddSubscriptionToHoa < ActiveRecord::Migration
  def change
    add_column :hoas, :subscription_type, :string, default: 'basic'
    add_column :hoas, :subscribed_until, :datetime
  end
end
