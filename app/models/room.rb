class Room < ApplicationRecord
    has_one_attached :image
    belongs_to :user


    validates :name, presence: true
    validates :description, presence: true
    validates :address, presence: true
    validates :price, presence: true
    validate  :price_integer

    private

    def price_integer
        if price.present? && price <= 0
            errors.add(:price, "は1円以上にしてください")
        end
    end
end
