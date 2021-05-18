require "csv"
CSV_COLUMNS = %w[name age height]

class User < ApplicationRecord
  def self.import_csv(file:)
    list = []
    CSV.foreach(file.path, headers: true) do |row|
      list << row.to_h.slice(*CSV_COLUMNS)
    end
    User.import(list)
  end

  def self.generate_csv
    CSV.generate do |csv|
      csv << CSV_COLUMNS
      all.each do |user|
        csv << CSV_COLUMNS.map { |col| user.send(col) }
      end
    end
  end
  # def self.import_csv(file:)
  #   now = Time.current
  #   timestamp_attributes = { created_at: now, updated_at: now }

  #   list = []
  #   CSV.foreach(file.path, headers: true) do |row|
  #     list << row.to_h.slice(*CSV_COLUMNS).merge(timestamp_attributes)
  #   end
  #   User.insert_all(list)
  # end

  # def self.import_csv(file:)
  #   User.transaction do
  #     CSV.foreach(file.path, headers: true) do |row|
  #       binding.pry
  #       create!(row.to_h.slice(*CSV_COLUMNS))
  #     end
  #   end
  # end
end
