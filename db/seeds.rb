users = [
    { name: "Pedro Bizzotto", email: "pedroabizzotto@gmail.com", password: "123456" }, 
    { name: "Cristiano Ronaldo", email: "cristianoronaldo@gmail.com", password: "123456" }, 
    { name: "Ayrton Senna", email: "ayrtonsenna@gmail.com", password: "123456"}
    ]

categories = [
    { name: "Research", parent_id: nil },
    { name: "Admin", parent_id: nil },
    { name: "Development", parent_id: nil },
    { name: "Meetings", parent_id: 2 },
    { name: "Emails", parent_id: 2 },
    { name: "Customer", parent_id: 3 },
    { name: "Project", parent_id: 3 },
    { name: "Writing Essay", parent_id: 1 },
    { name: "Reading Docs", parent_id: 1 },
    { name: "Google", parent_id: 6 },
    { name: "Facebook", parent_id: 6 },
    { name: "project#1", parent_id: 7 },
    { name: "project#2", parent_id: 7 }
]

tasks = [
    {title: "Activity for Pedro"},
    {title: "Activity 2 for Pedro"},
    {title: "Activity 3 for Pedro"},
    {title: "Activity 4 for Pedro"}
]

User.create(users)
Category.create(categories)
User.first.tasks.create(tasks)