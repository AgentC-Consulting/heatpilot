cask "heatpilot" do
  version "1.1.1"
  sha256 "d61081425491852f17558b33e4f77871863be2bb4a5de5fb6313fb328af31a5a"

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
