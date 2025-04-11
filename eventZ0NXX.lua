-- Получаем сервисы
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Функция телепортации яиц (универсальная)
local function teleportEggs(folderPath, eggPrefix, startIndex, endIndex)
    local eggFolder = folderPath
    for i = startIndex, endIndex do
        local eggName = eggPrefix .. "_" .. i
        local egg = eggFolder:FindFirstChild(eggName)
        if egg then
            egg.Position = humanoidRootPart.Position + Vector3.new(0, 2, 0)
            print("Телепортировано: " .. egg.Name)
        else
            print("Яйцо не найдено: " .. eggName)
        end
        wait(1)
    end
    print("Телепортация для " .. eggPrefix .. " завершена!")
end

-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EggHuntTeleportGui"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

-- Анимация надписи "z0nxx"
local introLabel = Instance.new("TextLabel")
introLabel.Size = UDim2.new(0, 400, 0, 100)
introLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
introLabel.BackgroundTransparency = 1
introLabel.Text = "z0nxx"
introLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
introLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
introLabel.TextStrokeTransparency = 0
introLabel.TextScaled = true
introLabel.Font = Enum.Font.GothamBlack
introLabel.TextTransparency = 1
introLabel.Parent = screenGui

-- Анимация появления и исчезновения надписи
local fadeIn = TweenService:Create(introLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 0})
local fadeOut = TweenService:Create(introLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1})

-- Запуск анимации
fadeIn:Play()
fadeIn.Completed:Connect(function()
    wait(3) -- Ждем 3 секунды
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        introLabel:Destroy() -- Удаляем надпись
    end)
end)

-- Создаем фрейм GUI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0.5, -110, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
frame.Visible = false -- Скрываем до конца анимации

-- Добавляем UI градиент
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
})
gradient.Rotation = 45
gradient.Parent = frame

-- Добавляем закругленные углы
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Добавляем тень
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = frame
shadow.ZIndex = -1

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Egg Hunt Teleport"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Крестик для закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = frame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy() -- Закрываем GUI
end)

-- Надпись "by z0nxx"
local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0, 20)
creditLabel.Position = UDim2.new(0, 0, 1, 5)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "by z0nxx"
creditLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
creditLabel.TextScaled = true
creditLabel.Font = Enum.Font.Gotham
creditLabel.Parent = frame

-- Функция для создания кнопки
local function createButton(name, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = button
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 100, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
    })
    btnGradient.Parent = button
    button.MouseButton1Click:Connect(function()
        character = player.Character or player.CharacterAdded:Wait()
        humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        callback()
    end)
end

-- Создаем кнопки
createButton("Easy", 60, function()
    teleportEggs(workspace:WaitForChild("EggHunt_Easy"), "Easy", 15, 40)
end)
createButton("Medium", 110, function()
    teleportEggs(workspace:WaitForChild("EggHunt_Medium"), "Medium", 1, 40)
end)
createButton("Hard", 160, function()
    teleportEggs(workspace:WaitForChild("EggHunt_Hard"), "Hard", 1, 40)
end)
createButton("Extreme", 210, function()
    teleportEggs(workspace:WaitForChild("EggHunt_Extreme"), "Extreme", 1, 40)
end)

-- Показываем GUI после анимации
fadeOut.Completed:Connect(function()
    frame.Visible = true
end)
