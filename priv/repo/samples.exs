# Script for populating the database. You can run it as:
#
#     mix run priv/repo/samples.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Edu.Repo.insert!(%Edu.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

ukraine = Edu.Repo.insert!(%Edu.Region{name: "Ukraine"})
vinnitsya = Edu.Repo.insert!(%Edu.Region{
  name: "Vinnytsia", parent_id: ukraine.id
})

library = Edu.Repo.insert!(%Edu.Location{
  name: "Library", region_id: vinnitsya.id
})

group = Edu.Repo.insert!(%Edu.Group{
  location_id: library.id
})

mentor_user = Edu.Repo.insert!(%Edu.User{
  email: "mentor@example.com"
})
mentor = Edu.Repo.insert!(%Edu.Mentor{
  group_id: group.id,
  user_id: mentor_user.id
})

student_user = Edu.Repo.insert!(%Edu.User{
  email: "student@example.com"
})
student = Edu.Repo.insert!(%Edu.Student{
  group_id: group.id,
  user_id: student_user.id
})
