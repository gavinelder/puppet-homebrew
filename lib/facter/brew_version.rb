require "facter"

Facter.add(:brew_version) do
  confine :operatingsystem => "Darwin"
  setcode do
    if Facter.value(:has_brew) == true
      if (Facter.value(:has_arm64) == false and File.exist?("/usr/local/bin/brew"))
        @brewbin = "/usr/local/bin/brew"
        true
      elsif (Facter.value(:has_arm64) == true and File.exist?("/opt/homebrew/bin/brew"))
        @brewbin = "/opt/homebrew/bin/brew"
      end

      Facter::Util::Resolution.with_env("PATH" => "/opt/homebrew/bin:/opt/homebrew/sbin") do
        brew_version = Facter::Util::Resolution.exec("/opt/homebrew/bin/brew --version | awk '/^Homebrew / {print $2}'")
      end
    else
      brew_version = "none"
    end
  end
end
