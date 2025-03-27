class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  attr_accessor :stay_duration, :total_price

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_people, presence: true
  validate :check_in_date_is_after_today
  validate :check_out_after_check_in
  validate :validate_number_of_people

  private
  
  def check_in_date_is_after_today
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付にしてください")
    end
  end

  def check_out_after_check_in
    if check_out_date.present? && check_in_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックインより後の日付にしてください")
    end
  end

  def validate_number_of_people
    if number_of_people.present? && number_of_people.to_i < 1
      errors.add(:number_of_people, "は1人以上でなければなりません")
    end
  end
end
