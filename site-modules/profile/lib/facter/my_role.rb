Facter.add(:my_role) do
  setcode do
    trusted = Facter.value(:trusted.certname)
    trusted
  end
end