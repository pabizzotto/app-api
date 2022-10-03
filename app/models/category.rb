class Category < ApplicationRecord

    validates :name, presence: true

    has_and_belongs_to_many :tasks

    belongs_to :parent, class_name: 'Category', optional: true

    scope :children, ->(id) { where(parent_id: id) }

    def has_parent?
        parent_id.present?
    end

    def parents
        return [] unless has_parent?
      
        current_category = parent
        parents = [current_category]

        while current_category.has_parent?
            current_category = current_category.parent
            parents << current_category
        end
      
        parents
    end

end
