class Room < ApplicationRecord
    has_one_attached :image
    belongs_to :user


    scope :search_by_address, ->(address) { where("address LIKE ?", "%#{address}%") if address.present? }

    # 施設名（name）でのあいまい検索
    scope :search_by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
  
    # 施設詳細（description）でのあいまい検索
    scope :search_by_description, ->(description) { where("description LIKE ?", "%#{description}%") if description.present? }
  
    # 住所（address）内でエリア（東京・大阪・京都・札幌）の部分一致検索
    scope :search_by_area, ->(area) { where("address LIKE ?", "%#{area}%") if area.present? }



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
