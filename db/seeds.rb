# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sammy = User.create(username: 'sammy', password: 'password')

gym = Plan.create(title: 'go to the gym regularly'.titleize, description: 'hit the gym twice a week', repeat: true, user_id: 1)
gym_goal_repeat = Goal.create(interval: 1, plan_id: 1)
gym_action_1 = Action.create(description: 'go to the gym for 30 min', goal_id: gym_goal_repeat.id)
gym_action_2 = Action.create(description: 'go to the gym for 30 min', goal_id: gym_goal_repeat.id)

hike = Plan.create(title: 'Get outside!'.titleize, description: 'spend an hour walking up, somewhere surrounded by trees', repeat: false, user_id: 1)
hike_goal = Goal.create(plan_id: 2, interval: 1)
hike_action_1 = Action.create(description: 'go for a 30 min walk', goal_id: hike_goal.id)

marathon = Plan.create(title: 'get ready for, and run, a half marathon'.titleize, description: 'run more and more each week', repeat: false, user_id: 1)
marathon_goal_1 = Goal.create(plan_id: 3, interval: 1)
marathon_goal_2 = Goal.create( plan_id: 3, interval: 1)
marathon_goal_3 = Goal.create( plan_id: 3, interval: 1)
marathon_goal_4 = Goal.create( plan_id: 3, interval: 1)
marathon_action_1 = Action.create(description: 'run 1 mile', goal_id: marathon_goal_1.id)
marathon_action_1_and_a_half = Action.create(description: 'sign up for a half marathon', goal_id: marathon_goal_1.id)
marathon_action_2 = Action.create(description: 'run 5 mile', goal_id: marathon_goal_2.id)
marathon_action_3 = Action.create(description: 'run 10 mile', goal_id: marathon_goal_3.id)
marathon_action_4 = Action.create(description: 'run a half marathon', goal_id: marathon_goal_4.id)
