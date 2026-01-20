local USER_KEY  = "100809"
local ADMIN_KEY = "lsh82541010"

-- ===== HWID + 만료시간 DB (선택사항) =====
local HWID_DB = {
    ["TEST_HWID"] = 1893456000, -- 예: 2030-01-01
}

-- ===== HWID 가져오기 함수 =====
local function getHWID()
    if typeof(gethwid) == "function" then
        return gethwid()
    elseif typeof(getfingerprint) == "function" then
        return getfingerprint()
    elseif typeof(identifyexecutor) == "function" then
        return identifyexecutor()
    end
    return "UNKNOWN"
end

local HWID = getHWID()
local NOW  = os.time()

-- ===== Rayfield 로드 =====
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ===== 관리자 플래그 =====
local isAdmin = false

-- ===== 윈도우 생성 =====
local Window = Rayfield:CreateWindow({
    Name = "Korean Hub",
    LoadingTitle = "Security Check",
    LoadingSubtitle = "키시스템 + 하드웨어인증 + 시간제 추가",
    ConfigurationSaving = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "키 인증",
        Subtitle = "키를 입력하세요",
        Note = "시간제 + HWID 시스템",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {USER_KEY, ADMIN_KEY},
        MaxAttempts = 2,
        Callback = function(inputKey)
            -- ✅ 입력된 키 확인
            if inputKey == ADMIN_KEY then
                isAdmin = true
                warn("✅ ADMIN ACCESS GRANTED")
            else
                isAdmin = false
            end

            -- HWID 체크 (관리자 아닌 경우만)
            if not isAdmin then
                local expire = HWID_DB[HWID]
                if not expire then
                    game.Players.LocalPlayer:Kick(
                        "❌ 등록되지 않은 HWID\nHWID: "..HWID
                    )
                    return
                end
                if NOW > expire then
                    game.Players.LocalPlayer:Kick(
                        "⏰ 사용 기간 만료\nHWID: "..HWID
                    )
                    return
                end
            end
        end
    }
})

-- ===== 탭 & UI =====
local Tab = Window:CreateTab("Main", 4483362458)
Tab:CreateSection("Scripts")

Tab:CreateButton({
    Name = "TG Script 실행",
    Callback = function()
        -- ✅ 실제 TG Script 실행
        loadstring(game:HttpGet('https://cdn.robloxscripts.gg/public/furky/furky-*no-key*-steal-a-brainrot-script-or-infinite-brainrots-or-admin-commands-or-auto-steal-source.lua'))()
    end
})

-- ===== 구성 불러오기 =====
Rayfield:LoadConfiguration()
