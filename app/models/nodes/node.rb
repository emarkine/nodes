module Nodes
  class Node < ApplicationRecord
    validates :name, :presence => true
    validates :title, :presence => true
    validates :file, :presence => true
    validates :user, :presence => true
    validates :date, :presence => true
  end
end
