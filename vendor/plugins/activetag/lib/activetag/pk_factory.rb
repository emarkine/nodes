gem "mongo"

require "mongo"

module ActiveTag #:nodoc
  class PKFactory
    def create_pk(row)
      return row if row[:_id]
      row.delete(:_id) # in case it exists but the value is nil
      row['_id'] ||= row.hash
      row
    end
  end
end