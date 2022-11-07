class AddCounterCacheToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :votes_count, :integer, default: 0
    Blog.find_each do |b|
      Blog.reset_counters b.id, :votes
    end
  end
end
