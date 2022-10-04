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

# transactions
	user_id
	spends int
	from_foreign_country boolean
	reworded boolean
	timestamp

# point_history
	user_id
	transaction_id
	point_earns int
	expired date
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
