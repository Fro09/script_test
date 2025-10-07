-- ServerScriptService.TrainingServer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- RemoteEvent 생성 (이미 있으면 중복 생성 방지)
local TrainEvent = ReplicatedStorage:FindFirstChild("TrainEvent")
if not TrainEvent then
	TrainEvent = Instance.new("RemoteEvent")
	TrainEvent.Name = "TrainEvent"
	TrainEvent.Parent = ReplicatedStorage
end

local StatModule = require(ReplicatedStorage.Modules.StatModule)

local playerStats = {}

Players.PlayerAdded:Connect(function(player)
	playerStats[player] = StatModule.new()
end)

Players.PlayerRemoving:Connect(function(player)
	playerStats[player] = nil
end)

TrainEvent.OnServerEvent:Connect(function(player)
	local stats = playerStats[player]
	if not stats then return end

	-- 서버에서만 Strength를 증가시킴 (클라이언트 신뢰 금지)
	stats = StatModule.Train(stats)
	playerStats[player] = stats

	-- 클라이언트로 현재 Strength만 전송
	TrainEvent:FireClient(player, stats.Strength)
end)
