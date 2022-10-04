# README




# users
	name
	birthday
	tier ["standard", "gold", "platinum" ]
	point_total 0
	cash_rebate_qualified boolean
	rebate_total 0
	timestamp

# point_historys
	user_id
	transection_id
	point_earns
	expired date
	timestamp

# transections
	user_id
	spends int
	point_earns int
	from_ foreign_country boolean
	reworded boolean
	timestamp

# rebate_historys
	user_id
	point
	timestamp

# rewords
	user_id
	reward_name
	used date
	timestamp
