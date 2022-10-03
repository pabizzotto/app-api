json.tasks @tasks do |task|
    json.id task.id
    json.title task.title
    json.register_at task.register_at.try(:strftime, ("%FT%R"))
    json.concluded_at task.concluded_at.try(:strftime, ("%FT%R"))
    json.duration task.duration
    json.status task.status.gsub('_', ' ').capitalize
    json.categories task.categories do |category|
        json.id category.id
        json.name category.name
        json.parents category.parents do |parent|
            json.id parent.id
            json.name parent.name
        end
    end
end