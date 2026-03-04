Facter.add(:saif_role) do
  setcode do
    fqdn = Facter.value('fqdn').to_s.downcase
    if fqdn.match?(/(oradev|oraprd|oranp|oramon|oradba|almagt)/)
      'db_server'
    elsif fqdn.match?(/(guiddev|guidprd)/)
      'guidewire'
    else
      'unknown_role'
    end
  end
end