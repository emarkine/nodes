class Address
  include Mongoid::Document
  field :street
  field :city
  field :state
  field :post_code
  belongs_to :person, :inverse_of => :addresses
end
