class AlertSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :body
end
