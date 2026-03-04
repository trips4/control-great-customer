Facter.add(:my_role) do
  setcode do
    trusted = Facter.value('trusted')
    certname = trusted.is_a?(Hash) ? trusted['certname'] : nil

    name = certname && !certname.empty? ? certname : Facter.value('fqdn').to_s
    name.include?('almagt') ? 'my_win' : 'default_role'
  end
end