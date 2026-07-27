cask "heatpilot" do
  version "1.0.0"
  sha256 "11dc7b0ee1f9a3ca079753ab33ae8a07619d928bffb2ec66e45086aef058a343"

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
