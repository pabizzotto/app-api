json.category do
    json.id @category.id
    json.name @category.name
    json.parents @category.parents.map(&:name)
end