-- =====================================================
-- SWILL RIVALS HUB - PRO VERSION (HARD LOCK & YAKIN HEDEF)
-- Gelişmiş UI, Hata Koruması, Mouse Aimbot ve Haberler Sistemi
-- =====================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Güvenli Temizlik İçin Bağlantı Deposu
local Connections = {}

-- ==========================================
-- GÜVENLİ MOUSE HAREKET SİSTEMİ (NIL HATASI ÇÖZÜMÜ)
-- ==========================================
local function SafeMouseMove(x, y)
    pcall(function()
        if mousemoverel then
            mousemoverel(x, y)
        elseif mousemoveabs then
            local currentPos = UserInputService:GetMouseLocation()
            mousemoveabs(currentPos.X + x, currentPos.Y + y)
        end
    end)
end

-- ==========================================
-- GELİŞMİŞ UI KÜTÜPHANESİ (MODERN & ŞIK)
-- ==========================================
local UI_COLORS = {
    Background = Color3.fromRGB(15, 15, 20),
    Container = Color3.fromRGB(22, 22, 28),
    Accent = Color3.fromRGB(255, 60, 90),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(170, 170, 190),
    ToggleOff = Color3.fromRGB(45, 45, 55),
    ToggleOn = Color3.fromRGB(255, 60, 90)
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SWILL_Rivals_Pro"
screenGui.ResetOnSpawn = false
pcall(function() screenGui.Parent = CoreGui end)
if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = UI_COLORS.Background
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = UI_COLORS.Accent
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.2
mainStroke.Parent = mainFrame

-- Başlık
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 20, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "SWILL RIVALS HUB | PRO"
titleText.TextColor3 = UI_COLORS.Accent
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 40)
tabContainer.Position = UDim2.new(0, 0, 0, 50)
tabContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
tabContainer.Parent = mainFrame

local pageContainer = Instance.new("Frame")
pageContainer.Size = UDim2.new(1, -20, 1, -110)
pageContainer.Position = UDim2.new(0, 10, 0, 100)
pageContainer.BackgroundTransparency = 1
pageContainer.Parent = mainFrame

local tabs = {}
local pages = {}

local function createTab(name, isDefault)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, #tabs * 120, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = isDefault and UI_COLORS.Accent or UI_COLORS.TextSecondary
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = tabContainer
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0.6, 0, 0, 3)
    indicator.Position = UDim2.new(0.2, 0, 1, -3)
    indicator.BackgroundColor3 = UI_COLORS.Accent
    indicator.BackgroundTransparency = isDefault and 0 or 1
    indicator.Parent = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = UI_COLORS.Accent
    page.Visible = isDefault
    page.Parent = pageContainer

    table.insert(tabs, {btn = btn, indicator = indicator, name = name})
    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            TweenService:Create(t.btn, TweenInfo.new(0.3), {TextColor3 = UI_COLORS.TextSecondary}):Play()
            TweenService:Create(t.indicator, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            pages[t.name].Visible = false
        end
        TweenService:Create(btn, TweenInfo.new(0.3), {TextColor3 = UI_COLORS.Accent}):Play()
        TweenService:Create(indicator, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        page.Visible = true
    end)
    return page
end

local function addToggle(page, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundColor3 = UI_COLORS.Container
    frame.Parent = page
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = UI_COLORS.TextPrimary
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -13)
    toggleBtn.BackgroundColor3 = UI_COLORS.ToggleOff
    toggleBtn.Text = ""
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        local targetColor = state and UI_COLORS.ToggleOn or UI_COLORS.ToggleOff
        local targetPos = state and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        
        TweenService:Create(toggleBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(circle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = targetPos}):Play()
        
        if callback then callback(state) end
    end)
    return frame
end

local function addButton(page, text, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)
end

-- ==========================================
-- HİLE DEĞİŞKENLERİ & MANTIK
-- ==========================================
local aimbotOn = false
local hardLockOn = false
local aimbotFOV = 150
local aimbotSmooth = 5
local wallCheckOn = false
local espOn = false
local aimbotConn = nil

local function isVisible(targetPart)
    if not wallCheckOn then return true end
    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    
    local result = Workspace:Raycast(origin, direction, raycastParams)
    if result and result.Instance:IsDescendantOf(targetPart.Parent) then
        return true
    end
    return false
end

local function findClosestEnemy()
    local closest, shortestDist = nil, math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local head = plr.Character.Head
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen and isVisible(head) then
                    local screenDist = (Vector2.new(pos.X, pos.Y) - center).magnitude
                    if screenDist < aimbotFOV and screenDist < shortestDist then
                        shortestDist = screenDist
                        closest = plr
                    end
                end
            end
        end
    end
    return closest
end

local function toggleAimbot()
    if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
    if not aimbotOn then return end

    aimbotConn = RunService.RenderStepped:Connect(function()
        local target = findClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local screenPos, onScreen = Camera:WorldToViewportPoint(headPos)
            
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                -- Hedefin konumundan farenin konumunu çıkararak ne kadar gidileceğini buluyoruz
                local moveX = (screenPos.X - mousePos.X)
                local moveY = (screenPos.Y - mousePos.Y)
                
                if hardLockOn then
                    SafeMouseMove(moveX, moveY) -- Salisesinde kafaya atlar
                else
                    SafeMouseMove(moveX / aimbotSmooth, moveY / aimbotSmooth) -- Smooth kayma
                end
            end
        end
    end)
    table.insert(Connections, aimbotConn)
end

local function applyESP(plr)
    if plr == LocalPlayer then return end
    local function addHighlight(char)
        if espOn and not char:FindFirstChild("SWILL_ESP") then
            local esp = Instance.new("Highlight")
            esp.Name = "SWILL_ESP"
            esp.FillColor = UI_COLORS.Accent
            esp.OutlineColor = Color3.fromRGB(255, 255, 255)
            esp.FillTransparency = 0.5
            esp.Parent = char
        end
    end
    
    if plr.Character then addHighlight(plr.Character) end
    local conn = plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        addHighlight(char)
    end)
    table.insert(Connections, conn)
end

-- ==========================================
-- SAYFALAR VE BUTONLAR
-- ==========================================
local pageCheats = createTab("HİLELER", true)
local pageSettings = createTab("AYARLAR", false)
local pageNews = createTab("HABERLER", false)

-- HİLELER SEKME İÇERİĞİ
local cY = 0
addToggle(pageCheats, "Mause Aimbot (Yakın Hedef)", cY, function(s) aimbotOn = s toggleAimbot() end)
cY = cY + 50
addToggle(pageCheats, "Hard Lock (Anında Kilitlenme)", cY, function(s) hardLockOn = s end)
cY = cY + 50
addToggle(pageCheats, "ESP (Duvar Arkası Görme)", cY, function(s)
    espOn = s
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local esp = plr.Character:FindFirstChild("SWILL_ESP")
            if s then applyESP(plr) elseif esp then esp:Destroy() end
        end
    end
end)
cY = cY + 50
addToggle(pageCheats, "Silah Sekmeme (No Recoil)", cY, function(s)
    local recoilConn
    if s then
        recoilConn = RunService.RenderStepped:Connect(function()
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                for _, v in pairs(tool:GetDescendants()) do 
                    if v.Name:lower() == "recoil" then pcall(function() v.Value = 0 end) end 
                end
            end
        end)
        table.insert(Connections, recoilConn)
    end
end)
cY = cY + 50
pageCheats.CanvasSize = UDim2.new(0, 0, 0, cY)

-- AYARLAR SEKME İÇERİĞİ
local sY = 0
addToggle(pageSettings, "Duvar Kontrolü (Wall Check)", sY, function(s) wallCheckOn = s end)
sY = sY + 50

-- MÜKEMMEL MENÜYÜ KALDIR ÖZELLİĞİ (CLEAN REMOVAL)
addButton(pageSettings, "MENÜYÜ KALDIR (TAM TEMİZLİK)", sY, Color3.fromRGB(200, 40, 40), function()
    -- Tüm döngüleri ve eventleri temizle
    for _, conn in ipairs(Connections) do
        if conn.Disconnect then pcall(function() conn:Disconnect() end) end
    end
    -- ESP'leri temizle
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("SWILL_ESP") then
            plr.Character.SWILL_ESP:Destroy()
        end
    end
    -- Gui'yi sil
    if screenGui then screenGui:Destroy() end
end)
sY = sY + 50
pageSettings.CanvasSize = UDim2.new(0, 0, 0, sY)

-- HABERLER SEKME İÇERİĞİ
local newsBox = Instance.new("Frame")
newsBox.Size = UDim2.new(1, -10, 0, 200)
newsBox.Position = UDim2.new(0, 5, 0, 0)
newsBox.BackgroundColor3 = UI_COLORS.Container
newsBox.Parent = pageNews
Instance.new("UICorner", newsBox).CornerRadius = UDim.new(0, 8)

local newsText = Instance.new("TextLabel")
newsText.Size = UDim2.new(1, -30, 1, -30)
newsText.Position = UDim2.new(0, 15, 0, 15)
newsText.BackgroundTransparency = 1
newsText.Text = "📰 GÜNCELLEME NOTLARI (PRO SÜRÜM)\n\n• UI Altyapısı kütüphane (Lib) formatına geçirildi ve modernize edildi.\n• Farenin anında veya yumuşak kitlenmesini sağlayan Mousemoverel hatası çözüldü ve Pcall ile korumaya alındı.\n• Tam Temizlik (Menüyü Kaldırma) özelliği eklendi.\n• ESP ve Aimbot optimizasyonları artırıldı."
newsText.TextColor3 = UI_COLORS.TextSecondary
newsText.TextSize = 13
newsText.Font = Enum.Font.Gotham
newsText.TextXAlignment = Enum.TextXAlignment.Left
newsText.TextYAlignment = Enum.TextYAlignment.Top
newsText.TextWrapped = true
newsText.Parent = newsBox

-- ==========================================
-- BAŞLATMA VE BİNDİNG
-- ==========================================
for _, plr in ipairs(Players:GetPlayers()) do applyESP(plr) end
Players.PlayerAdded:Connect(function(plr) applyESP(plr) end)

local menuToggleConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)
table.insert(Connections, menuToggleConn)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SWILL PRO YÜKLENDİ",
        Text = "Arayüzü açıp kapatmak için SAĞ SHIFT tuşunu kullanın.",
        Duration = 5
    })
end)
