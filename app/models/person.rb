class Person
  include Mongoid::Document
  field :name
  field :surname
  has_one :address
  has_many :phones
end
