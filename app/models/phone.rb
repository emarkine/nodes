class Phone
#  include Mongoid::Document
#  field :country_code, :type => Integer, :default => 1
#  field :number
#  belongs_to :person, :inverse_of => :phones
end
