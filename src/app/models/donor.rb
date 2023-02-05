class Donor < ApplicationRecord
    has_many :donation, foreign_key: :donor_name
end
