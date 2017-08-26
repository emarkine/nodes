module Nodes
  class Node < ApplicationRecord
    validates :name, presence: true
    validates :date, presence: true
  end
end
