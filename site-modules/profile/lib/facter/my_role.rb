Facter.add(:my_role) do
  setcode do
    trusted = Facter.value('trusted')
    certname = trusted.is_a?(Hash) ? trusted['certname'] : ''
    certname.include?('almagt') ? 'my_win' : 'default_role'
  end
end