require 'facter'

Facter.add(:brew_version) do
    confine :operatingsystem => 'Darwin'
    setcode do
    if Facter.value(:has_brew) == true
        if (Facter.value(:has_arm64) == false and File.exist?('/usr/local/bin/brew')) then
            @brewbin = '/usr/local/bin/brew'
            true
            elsif (Facter.value(:has_arm64) == true and  File.exist?('/opt/homebrew/bin/brew')) then
            @brewbin = '/opt/homebrew/bin/brew'
        end
        brew_version = Facter::Util::Resolution.exec("#{@brewbin} --version")
    else
        brew_version = 'none'
    end
    end
end
