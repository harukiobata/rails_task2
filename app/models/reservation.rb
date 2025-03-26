class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_people, presence: true, numericality: { greater_than_or_equal_to: 1, message: "は1人以上でなければなりません" }
  validate :check_in_date_is_after_today
  validate :check_out_after_check_in

  private

  def check_in_date_is_after_today
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付にしてください")
    end
  end

  def check_out_after_check_in
    if check_out_date.present? && check_in_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付にしてください")
    end
  end
end
