cask "heatpilot" do
  version "1.1.3"
  sha256 "7d6d09af3ef70ab74783713c6f94e9de0fbacd67087d59c239954e022cb95d9b"

  url "https://github.com/AgentC-Consulting/heatpilot/releases/download/v#{version}/HeatPilot-Installer.dmg"
  name "HeatPilot"
  desc "Free menu-bar fan control for Apple Silicon Macs"
  homepage "https://agentc.consulting/heatpilot"

  livecheck do
    url "https://github.com/AgentC-Consulting/heatpilot/releases"
    strategy :github_releases
    regex(/^v?(\d+\.\d+\.\d+)$/i)
  end

  auto_updates true
  depends_on macos: :sonoma
  depends_on arch:  :arm64

  app "HeatPilot.app"

  zap trash: [
    "/Library/Application Support/HeatPilot",
    "/Library/Logs/HeatPilot.log",
    "~/Library/Application Support/HeatPilot",
    "~/Library/Caches/com.agentc.heatpilot",
    "~/Library/HTTPStorages/com.agentc.heatpilot",
    "~/Library/Preferences/com.agentc.heatpilot.plist",
  ]
end
