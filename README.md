# README


users
	id
	name
	timestamp
	tier ["standard", "gold", "platinum" ]
	point_total 0
	rebate_total 0

points_history
	user_id
	transection_id
	point_earns
	expired date

transections
	user_id
	spends int
	point_earns int
	from_ foreign_country boolean
	reworded boolean
	timestamp

rebate_history
	user_id
	point
	timestamp

rewords
	user_id
	reward_name
	used date
	timestamp
