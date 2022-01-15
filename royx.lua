local royxui = {}

do  local ui =  game:GetService("CoreGui").RobloxGui.Modules:FindFirstChild("Royx")  if ui then ui:Destroy() end end

repeat wait() until game:IsLoaded()

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local tween = game:GetService("TweenService")

local Royx = Instance.new("ScreenGui")

Royx.Name = "Royx"
Royx.Parent = game:GetService("CoreGui").RobloxGui.Modules
Royx.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn then
	syn.protect_gui(game:GetService("CoreGui").RobloxGui.Modules:FindFirstChild("Royx"))
end

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local function Tween(instance, properties,style,wa)
	if style == nil or "" then
		return Back
	end
	tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Circle")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.5)
		Circle:Destroy()
	end)
end

function royxui:royxstart(text,logo)
	focusui = false
	
	if logo == nil then
		logo = 8543527952
	end
	
	local MainSceen = Instance.new("Frame")
	
	MainSceen.Name = "MainSceen"
	MainSceen.Parent = Royx
	MainSceen.Active = true
	MainSceen.AnchorPoint = Vector2.new(0.5, 0.5)
	MainSceen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	MainSceen.BorderColor3 = Color3.fromRGB(10, 10, 10)
	MainSceen.Position = UDim2.new(0.483071834, 0, 0.437730134, 0)
	MainSceen.Size = UDim2.new(0, 553, 0, 466)
	
	local Main_UiConner = Instance.new("UICorner")
	
	Main_UiConner.CornerRadius = UDim.new(0, 9)
	Main_UiConner.Name = "Main_UiConner"
	Main_UiConner.Parent = MainSceen
	
	local ClickFrame = Instance.new("Frame")
	
	ClickFrame.Name = "ClickFrame"
	ClickFrame.Parent = MainSceen
	ClickFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ClickFrame.BackgroundColor3 = Color3.fromRGB(240, 244, 242)
	ClickFrame.BackgroundTransparency = 1.000
	ClickFrame.Position = UDim2.new(0.523499548, 0, 0.0531321168, 0)
	ClickFrame.Size = UDim2.new(0, 527, 0, 34)
	
	local NameReal = Instance.new("TextLabel")
	
	NameReal.Name = "NameReal"
	NameReal.Parent = MainSceen
	NameReal.Active = true
	NameReal.AnchorPoint = Vector2.new(0.5, 0)
	NameReal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameReal.BackgroundTransparency = 1.000
	NameReal.Position = UDim2.new(0.513530612, 17, 0.0316386409, 0)
	NameReal.Size = UDim2.new(0.931070328, -14, -0.0002422783, 20)
	NameReal.Font = Enum.Font.GothamSemibold
	NameReal.Text = tostring(text)
	NameReal.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameReal.TextSize = 13.000
	NameReal.TextWrapped = true
	NameReal.TextXAlignment = Enum.TextXAlignment.Left
	
	local LogoTop = Instance.new("ImageLabel")
	
	LogoTop.Name = "LogoTop"
	LogoTop.Parent = NameReal
	LogoTop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoTop.BackgroundTransparency = 1.000
	LogoTop.Position = UDim2.new(-0.101428136, 0, -0.754071355, 0)
	LogoTop.Size = UDim2.new(0, 50, 0, 50)
	LogoTop.Image = "http://www.roblox.com/asset/?id="..tostring(logo)
	LogoTop.ScaleType = Enum.ScaleType.Crop
	
	local UIGradient = Instance.new("UIGradient")
	
	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
	UIGradient.Parent = NameReal
	
	local Line1 = Instance.new("Frame")
	
	Line1.Name = "Line1"
	Line1.Parent = MainSceen
	Line1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Line1.BorderColor3 = Color3.fromRGB(33, 35, 38)
	Line1.BorderSizePixel = 0
	Line1.Position = UDim2.new(0, 0, 0.100000016, 0)
	Line1.Size = UDim2.new(0, 553, 0, 1)
	
	local Line1_2 = Instance.new("Frame")
	
	Line1_2.Name = "Line1"
	Line1_2.Parent = MainSceen
	Line1_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Line1_2.BorderColor3 = Color3.fromRGB(33, 35, 38)
	Line1_2.BorderSizePixel = 0
	Line1_2.Position = UDim2.new(0.203297183, 0, 0.102145933, 0)
	Line1_2.Size = UDim2.new(0, 1, 0, 418)
	
	local MainSceen2 = Instance.new("Frame")
	
	MainSceen2.Name = "MainSceen2"
	MainSceen2.Parent = MainSceen
	MainSceen2.Active = true
	MainSceen2.AnchorPoint = Vector2.new(0.5, 0.5)
	MainSceen2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	MainSceen2.BackgroundTransparency = 1.000
	MainSceen2.BorderSizePixel = 0
	MainSceen2.Position = UDim2.new(0.61414808, 0, 0.551475704, 0)
	MainSceen2.Size = UDim2.new(0, 426, 0, 418)
	
	local ScolTapBarFrame = Instance.new("Frame")
	
	ScolTapBarFrame.Name = "ScolTapBarFrame"
	ScolTapBarFrame.Parent = MainSceen2
	ScolTapBarFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScolTapBarFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	ScolTapBarFrame.BackgroundTransparency = 1.000
	ScolTapBarFrame.BorderSizePixel = 0
	ScolTapBarFrame.Position = UDim2.new(-0.165286928, 0, 0.602597952, 5)
	ScolTapBarFrame.Selectable = true
	ScolTapBarFrame.Size = UDim2.new(0.287378728, -10, 0.715915382, 23)
	
	local ScrollingFrame_Menubar = Instance.new("ScrollingFrame")
	
	ScrollingFrame_Menubar.Name = "ScrollingFrame_Menubar"
	ScrollingFrame_Menubar.Parent = ScolTapBarFrame
	ScrollingFrame_Menubar.Active = true
	ScrollingFrame_Menubar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame_Menubar.BackgroundTransparency = 1.000
	ScrollingFrame_Menubar.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ScrollingFrame_Menubar.BorderSizePixel = 0
	ScrollingFrame_Menubar.Position = UDim2.new(0, 0, 0.004063047, 0)
	ScrollingFrame_Menubar.Size = UDim2.new(1.08894944, -10, 0.922974825, 23)
	ScrollingFrame_Menubar.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	ScrollingFrame_Menubar.ScrollBarThickness = 3
	
	local UIListLayout_Menubar = Instance.new("UIListLayout")
	local UIPadding_Menubar = Instance.new("UIPadding")
	
	UIListLayout_Menubar.Name = "UIListLayout_Menubar"
	UIListLayout_Menubar.Parent = ScrollingFrame_Menubar
	UIListLayout_Menubar.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_Menubar.Padding = UDim.new(0, 25)

	UIPadding_Menubar.Name = "UIPadding_Menubar"
	UIPadding_Menubar.Parent = ScrollingFrame_Menubar
	UIPadding_Menubar.PaddingLeft = UDim.new(0, 10)
	UIPadding_Menubar.PaddingTop = UDim.new(0, 7)
	
	local PageOrders = -1
	
	local Container_Page = Instance.new("Frame")
	
	Container_Page.Name = "Container_Page"
	Container_Page.Parent = MainSceen2
	Container_Page.AnchorPoint = Vector2.new(0.5, 0.5)
	Container_Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Container_Page.BackgroundTransparency = 1.000
	Container_Page.Position = UDim2.new(0.485153705, 0, 0.499208599, 0)
	Container_Page.Size = UDim2.new(0, 439, 0, 417)
	Container_Page.ClipsDescendants = true
	
	local pagesFolder = Instance.new("Folder")
	
	pagesFolder.Name = "pagesFolder"
	pagesFolder.Parent = Container_Page
	
	local UIPage = Instance.new("UIPageLayout")
	
	UIPage.Name = "UIPage"
	UIPage.Parent = pagesFolder
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIPage.EasingStyle = Enum.EasingStyle.Cubic
	UIPage.Padding = UDim.new(0, 15)
	UIPage.TweenTime = 0.500
	
	MakeDraggable(ClickFrame,MainSceen)
	MakeDraggable(ScrollingFrame_Menubar,MainSceen)
	
	local royxtabui = {}
	
	function royxtabui:royxtab(text,logo)
		if logo == nil then
			logo = 8543527952
		end
		PageOrders = PageOrders + 1

		local name = tostring(text) or tostring(math.random(1,5000))
		
		local Frame_Tap = Instance.new("Frame")
		
		Frame_Tap.Name = text.."Server"
		Frame_Tap.Parent = ScrollingFrame_Menubar
		Frame_Tap.Active = true
		Frame_Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame_Tap.BackgroundTransparency = 1.000
		Frame_Tap.Size = UDim2.new(0, 70, 0, 24)
		
		local TextButton_Tap = Instance.new("TextButton")
		
		TextButton_Tap.Name = "TextButton_Tap"
		TextButton_Tap.Parent = Frame_Tap
		TextButton_Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton_Tap.BackgroundTransparency = 1.000
		TextButton_Tap.Position = UDim2.new(0.114666745, 0, 0.100000381, 0)
		TextButton_Tap.Size = UDim2.new(0, 66, 0, 20)
		TextButton_Tap.Font = Enum.Font.Gotham
		TextButton_Tap.Text = tostring(text)
		TextButton_Tap.TextColor3 = Color3.fromRGB(255,255,255)
		TextButton_Tap.TextSize = 11.000
		TextButton_Tap.TextWrapped = true
		TextButton_Tap.TextXAlignment = Enum.TextXAlignment.Left
		
		local TextButton_Label = Instance.new("TextLabel")
		
		TextButton_Label.Name = "TextButton_Label"
		TextButton_Label.Parent = Frame_Tap
		TextButton_Label.Active = true
		TextButton_Label.AnchorPoint = Vector2.new(0.5, 0.5)
		TextButton_Label.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
		TextButton_Label.BorderSizePixel = 0
		TextButton_Label.Position = UDim2.new(-0.02, 0, 0.481999993, 0)
		TextButton_Label.Size = UDim2.new(0, 0, 0, 0)
		TextButton_Label.Font = Enum.Font.SourceSans
		TextButton_Label.Text = ""
		TextButton_Label.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton_Label.TextSize = 14.000
		
		local UICorner = Instance.new("UICorner")
		
		UICorner.Parent = TextButton_Label
		
		local LogoBar = Instance.new("ImageLabel")
		
		LogoBar.Name = "LogoBar"
		LogoBar.Parent = NameReal
		LogoBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoBar.BackgroundTransparency = 1.000
		LogoBar.Position = UDim2.new(-0.0854563117, 0, 2.21267605, 0)
		LogoBar.Size = UDim2.new(0, 85, 0, 85)
		LogoBar.Image = "http://www.roblox.com/asset/?id="..tostring(logo)
		LogoBar.ScaleType = Enum.ScaleType.Crop
		
		local MainPage = Instance.new("Frame")
		
		MainPage.Name = name.."_MainPage"
		MainPage.Parent = pagesFolder
		MainPage.Active = true
		MainPage.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		MainPage.BackgroundTransparency = 1.000
		MainPage.BorderSizePixel = 0
		MainPage.ClipsDescendants = true
		MainPage.Position = UDim2.new(0, 0, -0.00133538188, 0)
		MainPage.Size = UDim2.new(0, 439, 0, 417)
		
		MainPage.LayoutOrder = PageOrders
		
		TextButton_Tap.MouseButton1Click:connect(function()
			if MainPage.Name == text.."_MainPage" then
				UIPage:JumpToIndex(MainPage.LayoutOrder)

			end
			for i ,v in next , ScrollingFrame_Menubar:GetChildren() do
				if v:IsA("Frame") then
					TweenService:Create(
						v.TextButton_Tap,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(109,109,109)}
					):Play()
					TweenService:Create(
						v.TextButton_Label,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 0, 0, 0)}
					):Play()
				end
				TweenService:Create(
					TextButton_Tap,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(255, 255, 255)}
				):Play()
				TweenService:Create(
					TextButton_Label,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 4, 0, 20)}
				):Play()
			end
		end)

		if focusui == false then
			TweenService:Create(
				TextButton_Tap,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextColor3 = Color3.fromRGB(255, 255, 255)}
			):Play()
			TweenService:Create(
				TextButton_Label,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Size = UDim2.new(0, 4, 0, 20)}
			):Play()

			MainPage.Visible = true
			Frame_Tap.Name  = text .. "Server"
			focusui  = true
		end
		local ScrollingFrame_Pagefrist = Instance.new("ScrollingFrame")
		
		ScrollingFrame_Pagefrist.Name = "ScrollingFrame_Pagefrist"
		ScrollingFrame_Pagefrist.Parent = MainPage
		ScrollingFrame_Pagefrist.Active = true
		ScrollingFrame_Pagefrist.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollingFrame_Pagefrist.BackgroundTransparency = 1.000
		ScrollingFrame_Pagefrist.BorderSizePixel = 0
		ScrollingFrame_Pagefrist.Position = UDim2.new(-0.000814728963, 0, -0.00108026376, 0)
		ScrollingFrame_Pagefrist.Size = UDim2.new(0, 439, 0, 417)
		ScrollingFrame_Pagefrist.CanvasSize = UDim2.new(0, 0, 0, 0)
		ScrollingFrame_Pagefrist.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
		ScrollingFrame_Pagefrist.ScrollBarThickness = 3
		
		local UIGridLayout_Pagefrist = Instance.new("UIGridLayout")
		local UIPadding_Pagefrist = Instance.new("UIPadding")
		
		UIGridLayout_Pagefrist.Name = "UIGridLayout_Pagefrist"
		UIGridLayout_Pagefrist.Parent = ScrollingFrame_Pagefrist
		UIGridLayout_Pagefrist.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout_Pagefrist.CellPadding = UDim2.new(0, 15, 0, 30)
		UIGridLayout_Pagefrist.CellSize = UDim2.new(0, 420, 0, 385)

		UIPadding_Pagefrist.Name = "UIPadding_Pagefrist"
		UIPadding_Pagefrist.Parent = ScrollingFrame_Pagefrist
		UIPadding_Pagefrist.PaddingLeft = UDim.new(0, 10)
		UIPadding_Pagefrist.PaddingTop = UDim.new(0, 25)
		
		local royxpageui = {}
		
		function royxpageui:royxpage(text)
			local Pageframe = Instance.new("Frame")
			
			Pageframe.Name = "Pageframe"
			Pageframe.Parent = ScrollingFrame_Pagefrist
			Pageframe.Active = true
			Pageframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Pageframe.BackgroundTransparency = 1.000
			Pageframe.BorderSizePixel = 0
			Pageframe.Size = UDim2.new(0, 435, 0, 395)
			
			local UICorner_3 = Instance.new("UICorner")
			
			UICorner_3.CornerRadius = UDim.new(0, 4)
			UICorner_3.Parent = Pageframe
			
			local PageStroke = Instance.new("UIStroke")

			PageStroke.Thickness = 1
			PageStroke.Name = ""
			PageStroke.Parent = Pageframe
			PageStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
			PageStroke.LineJoinMode = Enum.LineJoinMode.Round
			PageStroke.Color = Color3.fromRGB(25,25,25)
			PageStroke.Transparency = 0
			
			local ScrollingFrame_Pageframe = Instance.new("ScrollingFrame")
			
			ScrollingFrame_Pageframe.Name = "ScrollingFrame_Pageframe"
			ScrollingFrame_Pageframe.Parent = Pageframe
			ScrollingFrame_Pageframe.Active = true
			ScrollingFrame_Pageframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScrollingFrame_Pageframe.BackgroundTransparency = 1.000
			ScrollingFrame_Pageframe.BorderSizePixel = 0
			ScrollingFrame_Pageframe.Size = UDim2.new(0, 421, 0, 379)
			ScrollingFrame_Pageframe.ScrollBarThickness = 3
			
			local ScrollingFrame_PageframeUIListLayout = Instance.new("UIListLayout")
			local ScrollingFrame_PageframeUIPadding = Instance.new("UIPadding")
			
			ScrollingFrame_PageframeUIListLayout.Name = "ScrollingFrame_PageframeUIListLayout"
			ScrollingFrame_PageframeUIListLayout.Parent = ScrollingFrame_Pageframe
			ScrollingFrame_PageframeUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ScrollingFrame_PageframeUIListLayout.Padding = UDim.new(0, 5)

			ScrollingFrame_PageframeUIPadding.Name = "ScrollingFrame_PageframeUIPadding"
			ScrollingFrame_PageframeUIPadding.Parent = ScrollingFrame_Pageframe
			ScrollingFrame_PageframeUIPadding.PaddingLeft = UDim.new(0, 10)
			ScrollingFrame_PageframeUIPadding.PaddingTop = UDim.new(0, 10)
			
			local TextPage = Instance.new("TextLabel")
			
			TextPage.Name = "TextPage"
			TextPage.Parent = Pageframe
			TextPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextPage.BackgroundTransparency = 1.000
			TextPage.Position = UDim2.new(0, 0, -0.0486538522, 0)
			TextPage.Size = UDim2.new(0, 420, 0, 17)
			TextPage.Font = Enum.Font.SourceSansLight
			TextPage.Text = tostring(text)
			TextPage.TextColor3 = Color3.fromRGB(109, 109, 109)
			TextPage.TextSize = 14.000
			TextPage.TextStrokeColor3 = Color3.fromRGB(109, 109, 109)
			TextPage.TextWrapped = true
			TextPage.TextXAlignment = Enum.TextXAlignment.Left
			
			local UICorner_2 = Instance.new("UICorner")
			local UICorner_4 = Instance.new("UICorner")

			UICorner_2.CornerRadius = UDim.new(0, 9)
			UICorner_2.Parent = MainSceen2

			UICorner_4.CornerRadius = UDim.new(0, 2)
			UICorner_4.Parent = MainPage
			
			ScrollingFrame_PageframeUIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				ScrollingFrame_Pageframe.CanvasSize = UDim2.new(0,0,0,ScrollingFrame_PageframeUIListLayout.AbsoluteContentSize.Y + 120)
			end)

			UIGridLayout_Pagefrist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				ScrollingFrame_Pagefrist.CanvasSize = UDim2.new(0,0,0,UIGridLayout_Pagefrist.AbsoluteContentSize.Y + 15)
			end)

			game:GetService("RunService").Stepped:Connect(function ()
				pcall(function ()
					ScrollingFrame_Menubar.CanvasSize = UDim2.new(0,0, 0,UIListLayout_Menubar.AbsoluteContentSize.Y + 20)
					ScrollingFrame_Pageframe.CanvasSize = UDim2.new(0,0,0,ScrollingFrame_PageframeUIListLayout.AbsoluteContentSize.Y +25)
					ScrollingFrame_Pagefrist.CanvasSize = UDim2.new(0,UIGridLayout_Pagefrist.AbsoluteContentSize.X + 18,0,0)
				end)
			end)
			
			local royxfunction = {}
			
			function royxfunction:Button(text,callback)
				local ButtonFrame = Instance.new("Frame")
				local ButtonMain = Instance.new("TextButton")
				local ButtonMainUICorner = Instance.new("UICorner")
				local TransparencyButton = Instance.new("TextButton")
				local TransparencyButtonUICorner = Instance.new("UICorner")

				ButtonFrame.Name = "ButtonFrame"
				ButtonFrame.Parent = ScrollingFrame_Pageframe
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonFrame.BackgroundTransparency = 1.000
				ButtonFrame.Size = UDim2.new(0, 407, 0, 38)

				ButtonMain.Name = "ButtonMain"
				ButtonMain.Parent = ButtonFrame
				ButtonMain.BackgroundColor3 = Color3.fromRGB(56, 112, 168)
				ButtonMain.BorderSizePixel = 0
				ButtonMain.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonMain.Position = UDim2.new(0.5, 0, 0.5, 0)
				ButtonMain.Size = UDim2.new(0, 397, 0, 27)
				ButtonMain.AutoButtonColor = false
				ButtonMain.Font = Enum.Font.GothamSemibold
				ButtonMain.TextColor3 = Color3.fromRGB(255, 255, 255)
				ButtonMain.TextSize = 11.000
				ButtonMain.Text = tostring(text)
				ButtonMain.ClipsDescendants = true

				ButtonMainUICorner.CornerRadius = UDim.new(0, 6)
				ButtonMainUICorner.Name = "ButtonMainUICorner"
				ButtonMainUICorner.Parent = ButtonMain

				TransparencyButton.Name = "TransparencyButton"
				TransparencyButton.Parent = ButtonMain
				TransparencyButton.AnchorPoint = Vector2.new(0.5, 0.5)
				TransparencyButton.BackgroundColor3 = Color3.fromRGB(56, 112, 168)
				TransparencyButton.BackgroundTransparency = 0.700
				TransparencyButton.BorderSizePixel = 0
				TransparencyButton.Position = UDim2.new(0.5, 0, 0.5, 0)
				TransparencyButton.Size = UDim2.new(0, 405, 0, 35)
				TransparencyButton.AutoButtonColor = false
				TransparencyButton.Font = Enum.Font.GothamSemibold
				TransparencyButton.Text = ""
				TransparencyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TransparencyButton.TextSize = 11.000
				
				TransparencyButtonUICorner.CornerRadius = UDim.new(0, 6)
				TransparencyButtonUICorner.Name = "TransparencyButtonUICorner"
				TransparencyButtonUICorner.Parent = TransparencyButton
				
				TransparencyButton.MouseEnter:Connect(function()
					TweenService:Create(
						ButtonMain,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(0, 0, 0)}
					):Play()
				end)
				
				TransparencyButton.MouseLeave:Connect(function()
					TweenService:Create(
						ButtonMain,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)}
					):Play()
				end)
				
				TransparencyButton.MouseButton1Click:Connect(function()
					CircleAnim(ButtonMain, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
					pcall(callback)
					TweenService:Create(
						ButtonMain,
						TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 385, 0, 27)}
					):Play()
					wait(0.1)
					TweenService:Create(
						ButtonMain,
						TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 397, 0, 27)}
					):Play()
					ButtonMain.TextSize = 0

					TweenService:Create(
						ButtonMain,
						TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
						{TextSize = 11}
					):Play()
				end)
			end
			
			function royxfunction:Toggle(text,logo,config,callback)
				if logo == nil then
					logo = 8543527952
				end
				local ToggleFrame = Instance.new("Frame")
				local ToggleMain = Instance.new("TextButton")
				local ToggleMainUICorner = Instance.new("UICorner")
				local LogoToggle = Instance.new("ImageLabel")
				local TextToggle = Instance.new("TextLabel")
				local Corner1 = Instance.new("TextButton")
				local Corner1UICorner = Instance.new("UICorner")
				local Corner2 = Instance.new("TextButton")
				local Corner2UICorner = Instance.new("UICorner")

				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = ScrollingFrame_Pageframe
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleFrame.BackgroundTransparency = 1.000
				ToggleFrame.Size = UDim2.new(0, 407, 0, 41)

				ToggleMain.Name = "ToggleMain"
				ToggleMain.Parent = ToggleFrame
				ToggleMain.BackgroundColor3 = Color3.fromRGB(56, 112, 168)
				ToggleMain.BackgroundTransparency = 1.000
				ToggleMain.BorderSizePixel = 0
				ToggleMain.Size = UDim2.new(0, 397, 0, 41)
				ToggleMain.AutoButtonColor = false
				ToggleMain.Font = Enum.Font.GothamSemibold
				ToggleMain.Text = ""
				ToggleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleMain.TextSize = 11.000
				ToggleMain.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleMain.Position = UDim2.new(0.5, 0, 0.5, 0)
				
				local ToggleMainStroke = Instance.new("UIStroke")

				ToggleMainStroke.Thickness = 1
				ToggleMainStroke.Name = ""
				ToggleMainStroke.Parent = ToggleMain
				ToggleMainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				ToggleMainStroke.LineJoinMode = Enum.LineJoinMode.Round
				ToggleMainStroke.Color = Color3.fromRGB(85, 170, 255)
				ToggleMainStroke.Transparency = 0.6

				ToggleMainUICorner.CornerRadius = UDim.new(0, 6)
				ToggleMainUICorner.Name = "ToggleMainUICorner"
				ToggleMainUICorner.Parent = ToggleMain

				LogoToggle.Name = "LogoToggle"
				LogoToggle.Parent = ToggleMain
				LogoToggle.Active = true
				LogoToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				LogoToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LogoToggle.BackgroundTransparency = 1.000
				LogoToggle.Position = UDim2.new(0.0500000007, 0, 0.5, 0)
				LogoToggle.Size = UDim2.new(0, 50, 0, 50)
				LogoToggle.Image = "http://www.roblox.com/asset/?id="..tostring(logo)

				TextToggle.Name = "TextToggle"
				TextToggle.Parent = LogoToggle
				TextToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextToggle.BackgroundTransparency = 1.000
				TextToggle.Position = UDim2.new(3.91000009, 0, 0.5, 0)
				TextToggle.Size = UDim2.new(0, 291, 0, 41)
				TextToggle.Font = Enum.Font.GothamSemibold
				TextToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextToggle.Text = tostring(text)
				TextToggle.TextSize = 11.000
				TextToggle.TextTransparency = 0.600
				TextToggle.TextXAlignment = Enum.TextXAlignment.Left

				Corner1.Name = "Corner1"
				Corner1.Parent = ToggleMain
				Corner1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Corner1.BorderSizePixel = 0
				Corner1.Position = UDim2.new(0.843828678, 0, 0.243902445, 0)
				Corner1.Size = UDim2.new(0, 50, 0, 20)
				Corner1.AutoButtonColor = false
				Corner1.Font = Enum.Font.SourceSans
				Corner1.Text = ""
				Corner1.TextColor3 = Color3.fromRGB(0, 0, 0)
				Corner1.TextSize = 14.000

				Corner1UICorner.CornerRadius = UDim.new(0, 30)
				Corner1UICorner.Name = "Corner1UICorner"
				Corner1UICorner.Parent = Corner1

				Corner2.Name = "Corner2"
				Corner2.Parent = Corner1
				Corner2.AnchorPoint = Vector2.new(0.5, 0.5)
				Corner2.BackgroundColor3 = Color3.fromRGB(62, 125, 188)
				Corner2.BorderSizePixel = 0
				Corner2.Position = UDim2.new(0.200000003, 0, 0.5, 0)
				Corner2.Size = UDim2.new(0, 15, 0, 15)
				Corner2.AutoButtonColor = false
				Corner2.Font = Enum.Font.SourceSans
				Corner2.Text = ""
				Corner2.TextColor3 = Color3.fromRGB(0, 0, 0)
				Corner2.TextSize = 14.000

				Corner2UICorner.CornerRadius = UDim.new(0, 30)
				Corner2UICorner.Name = "Corner2UICorner"
				Corner2UICorner.Parent = Corner2
				
				local check = {toogle = false ; togfunction = {

				};}
				
				ToggleMain.MouseEnter:Connect(function()
					if check.toogle == false then
						TweenService:Create(
							ToggleMainStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextToggle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end
				end)
				ToggleMain.MouseLeave:Connect(function()
					if check.toogle == false then
						TweenService:Create(
							ToggleMainStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextToggle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end
				end)
				
				ToggleMain.MouseButton1Click:Connect(function()
					if check.toogle == false then
						TweenService:Create(
							ToggleMainStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextToggle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner1,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(35,35,35)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner2,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Position = UDim2.new(0.78, 0, 0.5, 0)} -- UDim2.new(0, 128, 0, 25)
						):Play()
					else
						TweenService:Create(
							ToggleMainStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextToggle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner1,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner2,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Position = UDim2.new(0.200000003, 0, 0.5, 0)} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end
						check.toogle = not check.toogle
						callback(check.toogle)
				end)
				
				if config == true then
					if check.toogle == false then
						TweenService:Create(
							ToggleMainStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextToggle,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner1,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 = Color3.fromRGB(35,35,35)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							Corner2,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Position = UDim2.new(0.78, 0, 0.5, 0)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						check.toogle = not check.toogle
						callback(check.toogle)
					end
				end
			end
			
			function royxfunction:Line()
				local LineFrame = Instance.new("Frame")
				local LineMain = Instance.new("Frame")
				local LineUIGradient = Instance.new("UIGradient")

				LineFrame.Name = "LineFrame"
				LineFrame.Parent = ScrollingFrame_Pageframe
				LineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LineFrame.BackgroundTransparency = 1.000
				LineFrame.Size = UDim2.new(0, 397, 0, 21)

				LineMain.Name = "LineMain"
				LineMain.Parent = LineFrame
				LineMain.AnchorPoint = Vector2.new(0.5, 0.5)
				LineMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LineMain.BorderSizePixel = 0
				LineMain.Position = UDim2.new(0.5, 0, 0.5, 0)
				LineMain.Size = UDim2.new(0, 397, 0, 2)

				LineUIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(36, 62, 89)), ColorSequenceKeypoint.new(0.51, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(0.85, Color3.fromRGB(36, 63, 90)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))}
				LineUIGradient.Name = "LineUIGradient"
				LineUIGradient.Parent = LineMain
			end
			
			function royxfunction:Label(text)
				
				local LabelRefresh = {}
				
				local LabelFrame = Instance.new("Frame")
				local LabelMain = Instance.new("TextLabel")

				LabelFrame.Name = "LabelFrame"
				LabelFrame.Parent = ScrollingFrame_Pageframe
				LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelFrame.BackgroundTransparency = 1.000
				LabelFrame.Size = UDim2.new(0, 397, 0, 41)

				LabelMain.Name = "LabelMain"
				LabelMain.Parent = LabelFrame
				LabelMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelMain.BackgroundTransparency = 1.000
				LabelMain.Size = UDim2.new(0, 397, 0, 41)
				LabelMain.Font = Enum.Font.GothamSemibold
				LabelMain.TextColor3 = Color3.fromRGB(85, 170, 255)
				LabelMain.TextSize = 12.000
				LabelMain.Text = tostring(text)
				LabelMain.TextWrapped = true
				
				function  LabelRefresh:Change(text2)
					LabelMain.Text = tostring(text2)
				end
				return  LabelRefresh
			end
			
			function royxfunction:Textbox(text,text2,callback)
				local TextFrame = Instance.new("Frame")

				TextFrame.Name = "TextFrame"
				TextFrame.Parent = ScrollingFrame_Pageframe
				TextFrame.Active = true
				TextFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				TextFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextFrame.BackgroundTransparency = 1.000
				TextFrame.Position = UDim2.new(0.55, 0, 0.5, 0)
				TextFrame.Size = UDim2.new(0, 401, 0, 41)

				local LabelNameSliderxd = Instance.new("TextLabel")

				LabelNameSliderxd.Name = "LabelNameSliderxd"
				LabelNameSliderxd.Parent = TextFrame
				LabelNameSliderxd.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				LabelNameSliderxd.Position = UDim2.new(0.025, 0, -0.2, 0)
				LabelNameSliderxd.BackgroundTransparency = 1
				LabelNameSliderxd.BorderSizePixel = 0
				LabelNameSliderxd.Size = UDim2.new(0, 397, 0, 25)
				LabelNameSliderxd.Font = Enum.Font.GothamSemibold
				LabelNameSliderxd.TextColor3 = Color3.fromRGB(136,136,138)
				LabelNameSliderxd.TextSize = 11.000
				LabelNameSliderxd.TextTransparency = 0
				LabelNameSliderxd.Text = tostring(text)
				LabelNameSliderxd.TextXAlignment = Enum.TextXAlignment.Left

				local ConerTextBox = Instance.new("UICorner")

				ConerTextBox.CornerRadius = UDim.new(0, 4)
				ConerTextBox.Name = "ConerTextBox"
				ConerTextBox.Parent = TextFrame

				local FrameBox = Instance.new("Frame")

				FrameBox.Name = "FrameBox"
				FrameBox.Parent = TextFrame
				FrameBox.AnchorPoint = Vector2.new(0.5, 0.5)
				FrameBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
				FrameBox.BackgroundTransparency = 1
				FrameBox.BorderSizePixel = 1
				FrameBox.ClipsDescendants = true
				FrameBox.Position = UDim2.new(0.5, 0, 0.8, 0)
				FrameBox.Size = UDim2.new(0, 397, 0, 25)
				
				local FrameBoxStroke = Instance.new("UIStroke")

				FrameBoxStroke.Thickness = 1
				FrameBoxStroke.Name = ""
				FrameBoxStroke.Parent = FrameBox
				FrameBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				FrameBoxStroke.LineJoinMode = Enum.LineJoinMode.Round
				FrameBoxStroke.Color = Color3.fromRGB(85, 170, 255)
				FrameBoxStroke.Transparency = 0.6

				local ConerTextBox2 = Instance.new("UICorner")

				--Properties:

				ConerTextBox2.CornerRadius = UDim.new(0, 5)
				ConerTextBox2.Name = "ConerTextBox2"
				ConerTextBox2.Parent = FrameBox

				local TextFrame2 = Instance.new("TextBox")

				TextFrame2.Name = "TextFrame2"
				TextFrame2.Parent = FrameBox
				TextFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
				TextFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextFrame2.BackgroundTransparency = 1.000
				TextFrame2.BorderSizePixel = 0
				TextFrame2.ClipsDescendants = true
				TextFrame2.Position = UDim2.new(0.53, 0, 0.5, 0)
				TextFrame2.Size = UDim2.new(0, 397, 0, 35)
				TextFrame2.Font = Enum.Font.GothamSemibold
				TextFrame2.PlaceholderText = text2
				TextFrame2.PlaceholderColor3 = Color3.fromRGB(155, 155, 155)
				TextFrame2.TextColor3 = Color3.fromRGB(155, 155, 155)
				TextFrame2.TextSize = 11
				TextFrame2.TextXAlignment = Enum.TextXAlignment.Left

				TextFrame.MouseEnter:Connect(function()
					TweenService:Create(
						FrameBoxStroke,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{PlaceholderColor3 = Color3.fromRGB(85, 170, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(85, 170, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)

				TextFrame.MouseLeave:Connect(function()
					TweenService:Create(
						FrameBoxStroke,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{PlaceholderColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)

				TextFrame2.FocusLost:Connect(function()
					if #TextFrame2.Text > 0 then
						pcall(callback,TextFrame2.Text)
					end
				end)
			end
			
			function royxfunction:Dropdown(text,option,callback)
				local FrameButton = Instance.new("Frame")

				--Properties:

				FrameButton.Name = "FrameButton"
				FrameButton.Parent = ScrollingFrame_Pageframe
				FrameButton.AnchorPoint = Vector2.new(0.5, 0.5)
				FrameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				FrameButton.BackgroundTransparency = 1.000
				FrameButton.Position = UDim2.new(10, 0, 0.347239256, 0)
				FrameButton.Size = UDim2.new(0, 401, 0, 5)

				local DropFrame = Instance.new("Frame")
				DropFrame.Name = "DropFrame"
				DropFrame.Parent = ScrollingFrame_Pageframe
				DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				DropFrame.BackgroundTransparency = 1
				DropFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				DropFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				DropFrame.Size = UDim2.new(0, 401, 0, 25)
				DropFrame.ClipsDescendants = true
				
				local FrameBoxStroke = Instance.new("UIStroke")

				FrameBoxStroke.Thickness = 1
				FrameBoxStroke.Name = ""
				FrameBoxStroke.Parent = DropFrame
				FrameBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				FrameBoxStroke.LineJoinMode = Enum.LineJoinMode.Round
				FrameBoxStroke.Color = Color3.fromRGB(85, 170, 255)
				FrameBoxStroke.Transparency = 0.6
				
				local ConnerDropFrame = Instance.new("UICorner")
				ConnerDropFrame.CornerRadius = UDim.new(0, 4)
				ConnerDropFrame.Name = "ConnerDropFrame"
				ConnerDropFrame.Parent = DropFrame
				local LabelFrameDrop = Instance.new("TextLabel")
				LabelFrameDrop.Name = "LabelFrameDrop"
				LabelFrameDrop.Parent = DropFrame
				LabelFrameDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelFrameDrop.BackgroundTransparency = 1.000
				LabelFrameDrop.Position = UDim2.new(0.01728395, 0, 0, 0)
				LabelFrameDrop.Size = UDim2.new(0, 397, 0, 25)
				LabelFrameDrop.Font = Enum.Font.GothamSemibold
				LabelFrameDrop.TextColor3 = Color3.fromRGB(136, 136, 138)
				LabelFrameDrop.TextSize = 11.000
				LabelFrameDrop.TextWrapped = true
				LabelFrameDrop.TextXAlignment = Enum.TextXAlignment.Left
				LabelFrameDrop.Text = tostring(text).." :"

				local DropArbt_listimage = Instance.new("ImageLabel")
				DropArbt_listimage.Name = "DropArbt_listimage"
				DropArbt_listimage.Parent = LabelFrameDrop
				DropArbt_listimage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropArbt_listimage.BackgroundTransparency = 1.000
				DropArbt_listimage.Position = UDim2.new(0.934673369, 0, 0.099999994, 0)
				DropArbt_listimage.Rotation = 90.000
				DropArbt_listimage.Size = UDim2.new(0, 20, 0, 20)
				DropArbt_listimage.Image = "rbxassetid://3926305904"
				DropArbt_listimage.ImageRectOffset = Vector2.new(724, 284)
				DropArbt_listimage.ImageRectSize = Vector2.new(33, 33)
				DropArbt_listimage.ImageTransparency = 0.500

				local ScolDown = Instance.new("ScrollingFrame")

				ScolDown.Name = "ScolDown"
				ScolDown.Parent = LabelFrameDrop
				ScolDown.Active = true
				ScolDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScolDown.BackgroundTransparency = 1.000
				ScolDown.BorderSizePixel = 0
				ScolDown.Position = UDim2.new(-0.0175879393, 0, 0.899999976, 0)
				ScolDown.Size = UDim2.new(0, 401, 0, 97)
				ScolDown.CanvasSize = UDim2.new(0, 0, 0, 2)
				ScolDown.ScrollBarThickness = 1

				local UIListLayoutlist = Instance.new("UIListLayout")
				local UIPaddinglist = Instance.new("UIPadding")

				UIListLayoutlist.Name = "UIListLayoutlist"
				UIListLayoutlist.Parent = ScolDown
				UIListLayoutlist.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayoutlist.Padding = UDim.new(0, 5)

				UIPaddinglist.Name = "UIPaddinglist"
				UIPaddinglist.Parent = ScolDown
				UIPaddinglist.PaddingTop = UDim.new(0, 5)

				local ButtonDrop = Instance.new("TextButton")

				ButtonDrop.Name = "ButtonDrop"
				ButtonDrop.Parent = DropFrame
				ButtonDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonDrop.BackgroundTransparency = 1.000
				ButtonDrop.ClipsDescendants = true
				ButtonDrop.Size = UDim2.new(0, 397, 0, 25)
				ButtonDrop.Font = Enum.Font.SourceSans
				ButtonDrop.Text = ""
				ButtonDrop.TextColor3 = Color3.fromRGB(0, 0, 0)
				ButtonDrop.TextSize = 14.000

				local dog = false

				local FrameSize = 58
				local cout = 0
				for i , v in pairs(option) do
					cout =cout + 1
					if cout == 1 then
						FrameSize = 58
					elseif cout == 2 then
						FrameSize = 95
					elseif cout >= 3 then
						FrameSize = 115
					end

					local ListFrame = Instance.new("Frame")

					ListFrame.Name = "ListFrame"
					ListFrame.Parent = ScolDown
					ListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					ListFrame.BackgroundTransparency = 1.000
					ListFrame.BorderSizePixel = 0
					ListFrame.Position = UDim2.new(0.5, 0, 0.163043484, 0)
					ListFrame.Size = UDim2.new(0, 401, 0, 30)

					local TextLabel_TapDro2p = Instance.new("TextLabel")

					TextLabel_TapDro2p.Name = "TextLabel_TapDro2p"
					TextLabel_TapDro2p.Parent = ListFrame
					TextLabel_TapDro2p.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel_TapDro2p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_TapDro2p.BackgroundTransparency = 1.000
					TextLabel_TapDro2p.Position = UDim2.new(0.508641958, 0, 0.5, 0)
					TextLabel_TapDro2p.Size = UDim2.new(0, 397, 0, 30)
					TextLabel_TapDro2p.Font = Enum.Font.GothamSemibold
					TextLabel_TapDro2p.TextColor3 = Color3.fromRGB(136, 136, 138)
					TextLabel_TapDro2p.TextSize = 11.000
					TextLabel_TapDro2p.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel_TapDro2p.Text = tostring(v)

					local ButtonDrop2 = Instance.new("TextButton")

					ButtonDrop2.Name = "ButtonDrop2"
					ButtonDrop2.Parent = ListFrame
					ButtonDrop2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonDrop2.BackgroundTransparency = 1.000
					ButtonDrop2.Size = UDim2.new(0, 397, 0, 30)
					ButtonDrop2.Font = Enum.Font.SourceSans
					ButtonDrop2.TextColor3 = Color3.fromRGB(0, 0, 0)
					ButtonDrop2.TextSize = 14.000
					ButtonDrop2.Text = ""

					local Line = Instance.new("Frame")

					Line.Name = "Line"
					Line.Parent = ButtonDrop2
					Line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					Line.BorderSizePixel = 0
					Line.Position = UDim2.new(0, 0, 1, 0)
					Line.Size = UDim2.new(0, 401, 0, 1)

					ButtonDrop2.MouseButton1Click:Connect(function()
						TweenService:Create(
							DropFrame,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 401, 0, 25)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							DropArbt_listimage,
							TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
							{Rotation = 90}
						):Play()
						LabelFrameDrop.Text =  text.." : "..tostring(v)
						callback(v)
						dog = not dog
					end)
					ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
				end
				
				ButtonDrop.MouseEnter:Connect(function()
					if dog == false then
						TweenService:Create(
							FrameBoxStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end
				end)
				
				ButtonDrop.MouseLeave:Connect(function()
					if dog == false then
						TweenService:Create(
							FrameBoxStroke,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end
				end)
				
				ButtonDrop.MouseButton1Click:Connect(function()
					if dog == false then
						TweenService:Create(
							DropFrame,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 401, 0, FrameSize)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							DropArbt_listimage,
							TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
							{Rotation = 270}
						):Play()
						ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
					else
						TweenService:Create(
							DropFrame,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 401, 0, 25)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							DropArbt_listimage,
							TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
							{Rotation = 90}
						):Play()
						ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
					end
					dog = not dog
				end)
				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
				local dropfunc = {}

				function dropfunc:Clear()
					LabelFrameDrop.Text = tostring(text).." :"
					TweenService:Create(
						DropFrame,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 401, 0, 25)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					dog = not dog
					for i, v in next, ScolDown:GetChildren() do
						if v:IsA("Frame") then
							v:Destroy()
						end
					end
				end
				function dropfunc:Add(t)
					local ListFrame = Instance.new("Frame")

					ListFrame.Name = "ListFrame"
					ListFrame.Parent = ScolDown
					ListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					ListFrame.BackgroundTransparency = 1.000
					ListFrame.BorderSizePixel = 0
					ListFrame.Position = UDim2.new(0.5, 0, 0.163043484, 0)
					ListFrame.Size = UDim2.new(0, 401, 0, 30)

					local TextLabel_TapDro2p = Instance.new("TextLabel")

					TextLabel_TapDro2p.Name = "TextLabel_TapDro2p"
					TextLabel_TapDro2p.Parent = ListFrame
					TextLabel_TapDro2p.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel_TapDro2p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel_TapDro2p.BackgroundTransparency = 1.000
					TextLabel_TapDro2p.Position = UDim2.new(0.508641958, 0, 0.5, 0)
					TextLabel_TapDro2p.Size = UDim2.new(0, 397, 0, 30)
					TextLabel_TapDro2p.Font = Enum.Font.GothamSemibold
					TextLabel_TapDro2p.TextColor3 = Color3.fromRGB(136, 136, 138)
					TextLabel_TapDro2p.TextSize = 11.000
					TextLabel_TapDro2p.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel_TapDro2p.Text = tostring(t)

					local ButtonDrop2 = Instance.new("TextButton")

					ButtonDrop2.Name = "ButtonDrop2"
					ButtonDrop2.Parent = ListFrame
					ButtonDrop2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonDrop2.BackgroundTransparency = 1.000
					ButtonDrop2.Size = UDim2.new(0, 397, 0, 30)
					ButtonDrop2.Font = Enum.Font.SourceSans
					ButtonDrop2.TextColor3 = Color3.fromRGB(0, 0, 0)
					ButtonDrop2.TextSize = 14.000
					ButtonDrop2.Text = ""

					local Line = Instance.new("Frame")

					Line.Name = "Line"
					Line.Parent = ButtonDrop2
					Line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					Line.BorderSizePixel = 0
					Line.Position = UDim2.new(0, 0, 1, 0)
					Line.Size = UDim2.new(0, 401, 0, 1)

					ButtonDrop2.MouseButton1Click:Connect(function()
						TweenService:Create(
							DropFrame,
							TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 401, 0, 25)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							DropArbt_listimage,
							TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
							{Rotation = 90}
						):Play()
						LabelFrameDrop.Text =  text.." : "..tostring(t)
						callback(t)
						dog = not dog
					end)
					ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10)
				end
				return dropfunc
			end
			
			function royxfunction:Slider(text,floor,min,max,de,lol,callback)

				local sliderfunc = {}
				local SliderFrame = Instance.new("Frame")

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = ScrollingFrame_Pageframe
				SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.ClipsDescendants = true
				SliderFrame.Position = UDim2.new(0.5, 0, 0.457317084, 0)
				SliderFrame.Size = UDim2.new(0, 401, 0, 47)

				local Main_UiStroke2 = Instance.new("UIStroke")

				Main_UiStroke2.Thickness = 1
				Main_UiStroke2.Name = ""
				Main_UiStroke2.Parent = SliderFrame
				Main_UiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Main_UiStroke2.LineJoinMode = Enum.LineJoinMode.Round
				Main_UiStroke2.Color = Color3.fromRGB(85, 170, 255)
				Main_UiStroke2.Transparency = 0.6

				local SliderFrame_UICorner = Instance.new("UICorner")
				SliderFrame_UICorner.Name = "SliderFrame_UICorner"
				SliderFrame_UICorner.Parent = SliderFrame
				SliderFrame_UICorner.CornerRadius = UDim.new(0, 4)

				local LabelNameSlider = Instance.new("TextLabel")

				LabelNameSlider.Name = "LabelNameSlider"
				LabelNameSlider.Parent = SliderFrame
				LabelNameSlider.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelNameSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSlider.BackgroundTransparency = 1.000
				LabelNameSlider.BorderSizePixel = 0
				LabelNameSlider.Position = UDim2.new(0.16, 0, 0.3, 0)
				LabelNameSlider.Size = UDim2.new(0, 114, 0, 20)
				LabelNameSlider.Font = Enum.Font.GothamSemibold
				LabelNameSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSlider.Text = tostring(text)
				LabelNameSlider.TextSize = 11.000
				LabelNameSlider.TextWrapped = true
				LabelNameSlider.TextXAlignment = Enum.TextXAlignment.Left

				local ShowValueFrame = Instance.new("Frame")

				ShowValueFrame.Name = "ShowValueFrame"
				ShowValueFrame.Parent = SliderFrame
				ShowValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ShowValueFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
				ShowValueFrame.BorderSizePixel = 0
				ShowValueFrame.Position = UDim2.new(0.9, 0, 0.285106391, 0)
				ShowValueFrame.Size = UDim2.new(0, 50, 0, 15)

				local Main_UiStroke3 = Instance.new("UIStroke")

				Main_UiStroke3.Thickness = 1
				Main_UiStroke3.Name = ""
				Main_UiStroke3.Parent = ShowValueFrame
				Main_UiStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Main_UiStroke3.LineJoinMode = Enum.LineJoinMode.Round
				Main_UiStroke3.Color = Color3.fromRGB(85, 170, 255)
				Main_UiStroke3.Transparency = 0.6
				
				SliderFrame.MouseEnter:Connect(function()
					TweenService:Create(
						Main_UiStroke3,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Main_UiStroke2,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)
				
				SliderFrame.MouseLeave:Connect(function()
					TweenService:Create(
						Main_UiStroke3,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Main_UiStroke2,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.6} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)

				local ShowValueFrameUICorner = Instance.new("UICorner")
				ShowValueFrameUICorner.CornerRadius = UDim.new(0, 4)
				ShowValueFrameUICorner.Name = "ShowValueFrameUICorner"
				ShowValueFrameUICorner.Parent = ShowValueFrame

				local DefaultValue = Instance.new("ImageButton")

				DefaultValue.Name = "Imatog"
				DefaultValue.Parent = SliderFrame
				DefaultValue.BackgroundTransparency = 1.000
				DefaultValue.BorderSizePixel = 0
				DefaultValue.Position = UDim2.new(0.65, 0, 0.15, 0)
				DefaultValue.Size = UDim2.new(0, 15, 0, 15)
				DefaultValue.Image = "rbxassetid://7072721335"
				DefaultValue.ImageColor3 =  Color3.fromRGB(255, 255, 255)

				local Addvalue = Instance.new("ImageButton")

				Addvalue.Name = "Imatog"
				Addvalue.Parent = SliderFrame
				Addvalue.BackgroundTransparency = 1.000
				Addvalue.BorderSizePixel = 0
				Addvalue.Position = UDim2.new(0.75, 0, 0.15, 0)
				Addvalue.Size = UDim2.new(0, 15, 0, 15)
				Addvalue.Image = "http://www.roblox.com/asset/?id=6035067836"
				Addvalue.ImageColor3 =  Color3.fromRGB(85, 170, 255)

				local Deletevalue = Instance.new("ImageButton")

				Deletevalue.Name = "Imatog"
				Deletevalue.Parent = SliderFrame
				Deletevalue.BackgroundTransparency = 1.000
				Deletevalue.BorderSizePixel = 0
				Deletevalue.Position = UDim2.new(0.70, 0, 0.15, 0)
				Deletevalue.Size = UDim2.new(0, 15, 0, 15)
				Deletevalue.Image = "http://www.roblox.com/asset/?id=6035047377"
				Deletevalue.ImageColor3 =  Color3.fromRGB(85, 170, 255)

				local CustomValue = Instance.new("TextBox")

				CustomValue.Name = "CustomValue"
				CustomValue.Parent = ShowValueFrame
				CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
				CustomValue.BackgroundColor3 = Color3.fromRGB(10,10,10)
				CustomValue.BackgroundTransparency = 1.000
				CustomValue.ClipsDescendants = true
				CustomValue.Position = UDim2.new(0.501112819, 0, 0.5, 0)
				CustomValue.Size = UDim2.new(0, 50, 0, 26)
				CustomValue.Font = Enum.Font.Gotham
				CustomValue.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
				CustomValue.Text = ""
				CustomValue.TextSize = 11
				CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				if floor == true then
					CustomValue.Text =  tostring(de and string.format("%.1f",(de / max) * (max - min) + min) or 0)
				else
					CustomValue.Text =  tostring(de and math.floor( (de / max) * (max - min) + min) or 0)
				end

				local ValueFrame = Instance.new("Frame")

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = SliderFrame
				ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
				ValueFrame.BorderSizePixel = 0
				ValueFrame.Position = UDim2.new(0.499824077, 0, 0.800000012, 0)
				ValueFrame.Size = UDim2.new(0, 395, 0, 5)

				local Main_UiStroke = Instance.new("UIStroke")

				Main_UiStroke.Thickness = 1
				Main_UiStroke.Name = ""
				Main_UiStroke.Parent = ValueFrame
				Main_UiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Main_UiStroke.LineJoinMode = Enum.LineJoinMode.Round
				Main_UiStroke.Color = Color3.fromRGB(0, 0, 0)
				Main_UiStroke.Transparency = 0

				local ValueFrameUICorner = Instance.new("UICorner")
				ValueFrameUICorner.CornerRadius = UDim.new(0, 4)
				ValueFrameUICorner.Name = "ShowValueFrameUICorner"
				ValueFrameUICorner.Parent = ValueFrame

				local PartValue = Instance.new("Frame")

				PartValue.Name = "PartValue"
				PartValue.Parent = ValueFrame
				PartValue.Active = true
				PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
				PartValue.BackgroundColor3 = Color3.fromRGB(10,10,10)
				PartValue.BackgroundTransparency = 1.000
				PartValue.Position = UDim2.new(0.498982757, 0, 0.300000012, 0)
				PartValue.Size = UDim2.new(0, 395, 0, 5)

				local MainValue = Instance.new("Frame")

				MainValue.Name = "MainValue"
				MainValue.Parent = PartValue
				MainValue.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
				MainValue.Position = UDim2.new(0.00101725257, 0, 0.200000003, 0)
				MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 5)
				MainValue.BorderSizePixel = 0

				local MainValueUICorner = Instance.new("UICorner")
				MainValueUICorner.CornerRadius = UDim.new(0, 4)
				MainValueUICorner.Name = "a"
				MainValueUICorner.Parent = MainValue

				local ConneValue = Instance.new("Frame")

				ConneValue.Name = "ConneValue"
				ConneValue.Parent = PartValue
				ConneValue.AnchorPoint = Vector2.new(0.5, 0.5)
				ConneValue.BackgroundColor3 = Color3.fromRGB(10,10,10)
				ConneValue.Position = UDim2.new((de or 0)/max, 0.5, 0.6,0, 0)
				ConneValue.Size = UDim2.new(0, 0, 0, 0)
				ConneValue.BorderSizePixel = 0

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(0, 300)
				UICorner.Parent = ConneValue
				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0.6,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							5
						)

					MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)

					ConneValue:TweenPosition(pos, "Out", "Sine", 0.2, true)
					if floor == true then
						local value = string.format("%.1f",((pos.X.Scale * max) / max) * (max - min) + min)
						CustomValue.Text = tostring(value)
						callback(value)
					else
						local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
						CustomValue.Text = tostring(value)
						callback(value)
					end



				end
				local dragging = false
				ConneValue.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				ConneValue.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false

						end
					end
				)
				SliderFrame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				SliderFrame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false

						end
					end
				)


				ValueFrame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				ValueFrame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false

						end
					end
				)
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)

				CustomValue.FocusLost:Connect(function()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.6, 0) , "Out", "Sine", 0.2, true)
					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
				end)
				Addvalue.MouseButton1Click:Connect(function ()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					pcall(function()
						CustomValue.Text  = CustomValue.Text  - tonumber(lol)
					end)
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					if  tonumber(CustomValue.Text) < min then
						CustomValue.Text  = min
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
					--   callback({ tonumber(CustomValue.Text),check2.toogle2})
					--  pcall(callback, CustomValue.Text)
				end)

				Deletevalue.MouseButton1Click:Connect(function ()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					pcall(function()
						CustomValue.Text  = CustomValue.Text  + tonumber(lol)
					end)
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					if  tonumber(CustomValue.Text) < min then
						CustomValue.Text  = min
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
					--callback({ tonumber(CustomValue.Text),check2.toogle2})
					--  pcall(callback, CustomValue.Text)
				end)
				DefaultValue.MouseButton1Click:Connect(function()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					pcall(function()
						CustomValue.Text  = tonumber(de)
					end)
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					if  tonumber(CustomValue.Text) < min then
						CustomValue.Text  = min
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)

					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
				end)

				function sliderfunc:Update(value)
					MainValue:TweenSize(UDim2.new((value or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					CustomValue.Text = value

					pcall(function()
						callback(value)
					end)
				end
				return sliderfunc
			end
			
			return royxfunction
		end
		return royxpageui
	end
	return royxtabui
end
return royxui
