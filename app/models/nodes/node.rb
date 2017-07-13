module Nodes
  class Node < ApplicationRecord
    validates :name, presence: true
  end
end
