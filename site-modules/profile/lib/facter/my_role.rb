Facter.add(:my_role) do
  setcode do
    fqdn = Facter.value('fqdn').to_s
    if fqdn.match?(/(oradev|oraprd|oranp|oramon|oradba|almagt)/)
      'db_server'
    else
      'unknown_role'
    end
  end
end