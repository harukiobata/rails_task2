class Room < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many  :reservations, dependent: :destroy


    scope :search_by_address, ->(address) { where("address LIKE ?", "%#{address}%") if address.present? }

    # 施設名または施設詳細で検索
    scope :search_by_name_or_description, ->(keyword) { where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%") }
    #同時検索用（:address,:keyword)
    scope :search_by_address_and_keyword, ->(address, keyword) { where("address LIKE ? AND (name LIKE ? OR description LIKE ?)", "%#{address}%", "%#{keyword}%", "%#{keyword}%")}

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
