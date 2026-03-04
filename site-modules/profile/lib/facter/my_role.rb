Facter.add(:my_role) do
  setcode do
    trusted = Facter.value(:trusted)
    certname = trusted.is_a?(Hash) ? trusted['certname'] : nil
    certname
  end
end