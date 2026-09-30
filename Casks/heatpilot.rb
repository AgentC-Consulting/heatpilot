cask "heatpilot" do
  version "1.1.2"
  sha256 "bbe73b02a9baea7cc849298834b50162e3c45f658d0c75c46e3ac634fdb5b1d1"

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
