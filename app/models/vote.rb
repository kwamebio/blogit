class Vote < ApplicationRecord
    belongs_to :blog, counter_cache: true
end
