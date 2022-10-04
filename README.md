# README




# users
    # with basic device property
	timestamp

# profiles
	name
	birthday
	tier ["standard", "gold", "platinum" ]
	point_total 0
	cash_rebate_qualified boolean
	rebate_total 0
	timestamp

# point_history
	user_id
	transection_id
	point_earns int
	expired date
	timestamp

# transactions
	user_id
	spends int
	from_ foreign_country boolean
	reworded boolean
	timestamp

# rebate_history
	user_id
    transaction_id
	point
	timestamp

# rewards
	user_id
	reward_name
	used date
	timestamp
