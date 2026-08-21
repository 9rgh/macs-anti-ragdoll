local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local function restoreCharacter()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end


	humanoid.PlatformStand = false
	humanoid.Sit = false
	humanoid.AutoRotate = true


	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("Motor6D") then
			obj.Enabled = true
		end
	end


	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("BallSocketConstraint")
			or obj:IsA("RodConstraint") then
			obj:Destroy()
		end
	end

	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

	task.wait(0.15)

	if humanoid.Health > 0 then
		humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end
end


UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.E then
		restoreCharacter()
	end
end)