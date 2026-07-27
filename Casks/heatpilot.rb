cask "heatpilot" do
  version "1.0.0"
  sha256 "e1c93539463e4390a21bc0a2b39762f141e48c605d4f1ff6be580d67c3c23dab"

  url "https://github.com/AgentC-Consulting/heatpilot/releases/download/v#{version}/HeatPilot-Installer.dmg"
  name "HeatPilot"
  desc "Free menu-bar fan control for Apple Silicon Macs"
  homepage "https://github.com/AgentC-Consulting/heatpilot"

  livecheck do
    url "https://github.com/AgentC-Consulting/heatpilot/releases"
    strategy :github_releases
    regex(/^v?(\d+\.\d+\.\d+)$/i)
  end

  depends_on macos: :sonoma
  depends_on arch:  :arm64

  app "HeatPilot.app"

  zap trash: [
    "~/Library/Application Support/HeatPilot",
  ]
end
