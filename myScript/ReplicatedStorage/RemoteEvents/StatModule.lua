-- ReplicatedStorage.Modules.StatModule
local StatModule = {}

function StatModule.new()
	return {
		Strength = 0,
		Speed = 10,
	}
end

function StatModule.Train(stats)
	stats.Strength += 1
	stats.Speed = 10 + math.floor(stats.Strength / 5)
	return stats
end

return StatModule