class County < ApplicationRecord
    validates :num_cur_cases, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_cur_cases_w, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_cur_cases_b, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_cur_cases_o, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :population, presence: true, numericality: { greater_than: 0}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_dr, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_dr_w, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_dr_b, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

    validates :num_dr_o, presence: true, numericality: { greater_than: -1, less_than: 5000}, 
    format: { with: /\A[a-z0-9A-Z'. :-]+\z/.freeze }

end
